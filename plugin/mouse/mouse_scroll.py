import time
from enum import Enum, auto
from typing import Literal, Optional

from talon import Context, Module, actions, app, cron, ctrl, imgui, settings, ui

hiss_scroll_up = False


class ScrollingDirection(Enum):
    UP = auto()
    DOWN = auto()
    LEFT = auto()
    RIGHT = auto()


class Scroller:
    """Understands how to scroll in a specific direction"""

    __slots__ = ("_scroll_dir", "_is_vertical", "direction")

    def __init__(self):
        self._set_down()

    def set_direction(self, direction: ScrollingDirection):
        self.direction = direction
        match direction:
            case ScrollingDirection.UP:
                self._set_up()
            case ScrollingDirection.DOWN:
                self._set_down()
            case ScrollingDirection.LEFT:
                self._set_left()
            case ScrollingDirection.RIGHT:
                self._set_right()

    def _set_up(self):
        self._is_vertical: bool = True
        self._scroll_dir = -1

    def _set_down(self):
        self._is_vertical: bool = True
        self._scroll_dir = 1

    def _set_left(self):
        self._is_vertical: bool = False
        self._scroll_dir = -1

    def _set_right(self):
        self._is_vertical: bool = False
        self._scroll_dir = 1

    def scroll_in_direction(self, amount: int):
        scroll_delta = self._scroll_dir * amount
        if self._is_vertical:
            actions.mouse_scroll(scroll_delta)
        else:
            actions.mouse_scroll(0, scroll_delta)

    def is_direction_equal_to(self, direction: ScrollingDirection) -> bool:
        return self.direction == direction

    def get_direction_name(self) -> str:
        return self.direction.name.lower()


class ScrollingState:
    __slots__ = (
        "_scroll_job",
        "_scroll_start_ts",
        "_is_control_mouse_forced",
        "continuous_scrolling_speed_factor",
        "scroller",
        "is_continuously_scrolling",
    )

    def __init__(self):
        self._scroll_job = None
        # The time stamp at which continuous scrolling started
        # used for acceleration
        self._scroll_start_ts: float = 0
        # True if eye tracking mouse control was forced on for gaze scroll
        self._is_control_mouse_forced = False
        self.continuous_scrolling_speed_factor: float = 1.0
        self.scroller = Scroller()
        self.is_continuously_scrolling: bool = False

    def start_continuous_scrolling_job(self):
        self.reset_scrolling_start_time()
        self.scroll_continuous_helper()
        scroll_job = cron.interval("16ms", self.scroll_continuous_helper)
        self.set_scrolling_job(scroll_job)
        self.is_continuously_scrolling = True

    def scroll_continuous_helper(self):
        speed = self.compute_scrolling_speed()
        self.scroller.scroll_in_direction(speed)

    def start_gaze_scrolling_job(self):
        self.continuous_scrolling_speed_factor = 1
        gaze_job = cron.interval("16ms", scroll_gaze_helper)
        self.set_scrolling_job(gaze_job)
        # enable 'control mouse' if eye tracker is present and not enabled already
        if not actions.tracking.control_enabled():
            actions.tracking.control_toggle(True)
            self._is_control_mouse_forced = True

    def set_scrolling_job(self, job):
        self.stop_scrolling_job()
        self._scroll_job = job

    def stop_scrolling_job(self):
        if self._scroll_job:
            cron.cancel(self._scroll_job)
            self._scroll_job = None
        if self._is_control_mouse_forced:
            actions.tracking.control_toggle(False)
            self._is_control_mouse_forced = False
        self.is_continuously_scrolling = False

    def has_scrolling_job(self) -> bool:
        return self._scroll_job is not None

    def compute_scrolling_speed(self) -> int:
        scroll_amount = (
            settings.get("user.mouse_continuous_scroll_amount")
            * self.continuous_scrolling_speed_factor
        )
        acceleration_setting = settings.get("user.mouse_continuous_scroll_acceleration")
        acceleration_speed = (
            1
            + min(
                (time.perf_counter() - self._scroll_start_ts) / 0.5,
                acceleration_setting - 1,
            )
            if acceleration_setting > 1
            else 1
        )

        accelerated_scroll_amount = round(scroll_amount * acceleration_speed)
        if accelerated_scroll_amount == 0:
            accelerated_scroll_amount = 1
        return accelerated_scroll_amount

    def compute_gaze_scrolling_factor(self) -> float:
        return self.continuous_scrolling_speed_factor * settings.get(
            "user.mouse_gaze_scroll_speed_multiplier"
        )

    def reset_scrolling_start_time(self):
        self._scroll_start_ts = time.perf_counter()

    def get_scrolling_mode_description(self):
        if not self.has_scrolling_job():
            return ""
        if self.is_continuously_scrolling:
            return f"scroll {self.scroller.get_direction_name()} continuous"
        return "gaze scroll"


scrolling_state = ScrollingState()

mod = Module()
ctx = Context()

mod.list(
    "continuous_scrolling_direction",
    desc="Defines names for directions used with continuous scrolling",
)

mod.setting(
    "mouse_wheel_down_amount",
    type=int,
    default=120,
    desc="The amount to scroll up/down (equivalent to mouse wheel on Windows by default)",
)
mod.setting(
    "mouse_wheel_horizontal_amount",
    type=int,
    default=40,
    desc="The amount to scroll left/right",
)
mod.setting(
    "mouse_continuous_scroll_amount",
    type=int,
    default=8,
    desc="The default amount used when scrolling continuously",
)
mod.setting(
    "mouse_continuous_scroll_acceleration",
    type=float,
    default=1,
    desc="The maximum (linear) acceleration factor when scrolling continuously. 1=constant speed/no acceleration",
)

mod.setting(
    "mouse_continuous_scroll_frequency",
    type=int,
    default=16,
    # my working default is 100ms
    # community default is 16ms
    desc="timeout frequency of scroll helper in ms",
)

mod.setting(
    "mouse_enable_hiss_scroll",
    type=bool,
    default=False,
    desc="Hiss noise scrolls down when enabled",
)
mod.setting(
    "mouse_hide_mouse_gui",
    type=bool,
    default=False,
    desc="When enabled, the 'Scroll Mouse' GUI will not be shown.",
)

mod.setting(
    "mouse_continuous_scroll_speed_quotient",
    type=float,
    default=10.0,
    desc="When adjusting the continuous scrolling speed through voice commands, the result is that the speed is multiplied by the dictated number divided by this number.",
)

mod.setting(
    "mouse_gaze_scroll_speed_multiplier",
    type=float,
    default=1.0,
    desc="This multiplies the gaze scroll speed",
)

mod.tag(
    "continuous_scrolling",
    desc="Allows commands for adjusting continuous scrolling behavior",
)


@imgui.open(x=700, y=0)
def gui_wheel(gui: imgui.GUI):
    gui.text(f"Scroll mode: {scrolling_state.get_scrolling_mode_description()}")
    gui.text("say a number between 0 and 99 to set scrolling speed")
    gui.line()
    if gui.button("[Wheel] Stop"):
        actions.user.mouse_scroll_stop()


@mod.action_class
class Actions:
    def mouse_scroll_up(amount: float = 1):
        """Scrolls up"""
        y = amount * settings.get("user.mouse_wheel_down_amount")
        actions.mouse_scroll(y)

    def mouse_scroll_down(amount: float = 1):
        """Scrolls down"""
        y = amount * settings.get("user.mouse_wheel_down_amount")
        actions.mouse_scroll(-y)

    def mouse_scroll_left(amount: float = 1):
        """Scrolls left"""
        x = amount * settings.get("user.mouse_wheel_horizontal_amount")
        actions.mouse_scroll(0, -x)

    def mouse_scroll_right(amount: float = 1):
        """Scrolls right"""
        x = amount * settings.get("user.mouse_wheel_horizontal_amount")
        actions.mouse_scroll(0, x)

    def mouse_scroll_continuous(direction: str, speed_factor: Optional[int] = None):
        """Scrolls continuously in the given direction"""
        try:
            enumerated_direction = ScrollingDirection[direction]
        except KeyError:
            raise ValueError(f"Invalid continuous scrolling direction: {direction}")
        mouse_scroll_continuous(enumerated_direction, speed_factor)

    def mouse_scroll_up_continuous(speed_factor: Optional[int] = None):
        """Scrolls up continuously"""
        mouse_scroll_continuous(1, speed_factor)

    def mouse_scroll_down_continuous(speed_factor: Optional[int] = None):
        """Scrolls down continuously"""
        mouse_scroll_continuous(-1, speed_factor)
        

    def mouse_scroll_right_continuous(speed_factor: Optional[int] = None):
        """Scrolls right continuously"""
        mouse_scroll_continuous(1, speed_factor, is_vertical=False)

    def mouse_scroll_left_continuous(speed_factor: Optional[int] = None):
        """Scrolls left continuously"""
        mouse_scroll_continuous(-1, speed_factor, is_vertical=False)

    def mouse_scroll_right_continuous(speed_factor: Optional[int] = None):
        """Scrolls right continuously"""
        mouse_scroll_continuous(ScrollingDirection.RIGHT, speed_factor)

    def mouse_scroll_left_continuous(speed_factor: Optional[int] = None):
        """Scrolls left continuously"""
        mouse_scroll_continuous(ScrollingDirection.LEFT, speed_factor)

    def mouse_gaze_scroll():
        """Starts gaze scroll"""

        ctx.tags = ["user.continuous_scrolling"]
        scrolling_state.start_gaze_scrolling_job()

        if not settings.get("user.mouse_hide_mouse_gui"):
            gui_wheel.show()

    def mouse_gaze_scroll_toggle():
        """If not scrolling, start gaze scroll, else stop scrolling."""
        if scrolling_state.has_scrolling_job():
            actions.user.mouse_scroll_stop()
        else:
            actions.user.mouse_gaze_scroll()

    def mouse_scroll_stop() -> bool:
        """Stops scrolling"""
        return_value = False
        ctx.tags = []

        if scrolling_state.has_scrolling_job():
            return_value = True
        scrolling_state.stop_scrolling_job()

        gui_wheel.hide()

        return return_value

    def mouse_scroll_set_speed(speed: Optional[int]):
        """Sets the continuous scrolling speed for the current scrolling"""
        global continuous_scrolling_speed_factor, scroll_start_ts
        print(f"speed = {speed}")
        if scroll_start_ts:
            scroll_start_ts = time.perf_counter()
        if speed is None:
            print("No speed given")
            continuous_scrolling_speed_factor = 1.0
        else:
            print(f"custom speed")
            speed_quotient = settings.get("user.mouse_continuous_scroll_speed_quotient")
            print(f"speed_quotient = {speed_quotient}")  
            continuous_scrolling_speed_factor = speed / speed_quotient
        print(f"continuous_scrolling_speed_factor = {continuous_scrolling_speed_factor}")

    def mouse_is_continuous_scrolling():
        """Returns whether continuous scroll is in progress"""
        return scrolling_state.has_scrolling_job()

    def hiss_scroll_up():
        """Change mouse hiss scroll direction to up"""
        global hiss_scroll_up
        hiss_scroll_up = True

    def hiss_scroll_down():
        """Change mouse hiss scroll direction to down"""
        global hiss_scroll_up
        hiss_scroll_up = False


@ctx.action_class("user")
class UserActions:
    def noise_trigger_hiss(active: bool):
        if settings.get("user.mouse_enable_hiss_scroll"):
            if active:
                if hiss_scroll_up:
                    actions.user.mouse_scroll_up_continuous()
                else:
                    actions.user.mouse_scroll_down_continuous()
            else:
                actions.user.mouse_scroll_stop()


def mouse_scroll_continuous(
    new_scroll_dir: ScrollingDirection,
    speed_factor: Optional[int] = None,
):
    global scroll_job, scroll_dir, scroll_start_ts, is_continuous_scrolling_vertical
    print(f"speed_factor = {speed_factor}")
    actions.user.mouse_scroll_set_speed(speed_factor)
    frequency = settings.get("user.mouse_continuous_scroll_frequency")
    print(f"frequency = {frequency}")

    was_vertical = is_continuous_scrolling_vertical
    is_continuous_scrolling_vertical = is_vertical

    update_continuous_scrolling_mode(new_scroll_dir, is_vertical)

    if scroll_job:
        print("scroll_job")
        # Issuing a scroll in the same direction aborts scrolling
        actions.user.mouse_scroll_stop()
    else:
        print("No scroll job")
        scroll_dir = new_scroll_dir
        scroll_start_ts = time.perf_counter()
        scroll_continuous_helper()
        scroll_job = cron.interval(f"{frequency}ms", scroll_continuous_helper)
        ctx.tags = ["user.continuous_scrolling"]

        if not settings.get("user.mouse_hide_mouse_gui"):
            gui_wheel.show()


def update_continuous_scrolling_mode(new_scroll_dir: Literal[-1, 1], is_vertical: bool):
    global continuous_scroll_mode
    if new_scroll_dir == -1:
        if is_vertical:
            continuous_scroll_mode = "scroll up continuous"
        else:
            continuous_scroll_mode = "scroll left continuous"
    else:
        if is_vertical:
            continuous_scroll_mode = "scroll down continuous"
        else:
            continuous_scroll_mode = "scroll right continuous"


def scroll_continuous_helper():
    scroll_amount = (
        settings.get("user.mouse_continuous_scroll_amount")
        * continuous_scrolling_speed_factor
    )
    print(f"scroll_amount = {scroll_amount}")
    acceleration_setting = settings.get("user.mouse_continuous_scroll_acceleration")
    print(f"acceleration_setting = {acceleration_setting}")
    acceleration_speed = (
        1 + min((time.perf_counter() - scroll_start_ts) / 0.5, acceleration_setting - 1)
        if acceleration_setting > 1
        else 1
    )
    print(f"acceleration_speed = {acceleration_speed}")

    scroll_delta = round(scroll_amount * acceleration_speed * scroll_dir)
    if scroll_delta == 0:
        scroll_delta = scroll_dir
    print(f"scroll delta final = {scroll_delta}\n")
    if is_continuous_scrolling_vertical:
        actions.mouse_scroll(scroll_delta)
    else:
        actions.mouse_scroll(0, scroll_delta)


def scroll_gaze_helper():
    x, y = ctrl.mouse_pos()

    # The window containing the mouse
    window = get_window_containing(x, y)

    if window is None:
        return

    rect = window.rect
    midpoint = rect.center.y
    factor = scrolling_state.compute_gaze_scrolling_factor()
    amount = factor * (((y - midpoint) / (rect.height / 10)) ** 3)
    actions.mouse_scroll(amount)


def get_window_containing(x: float, y: float):
    # on windows, check the active_window first since ui.windows() is not z-ordered
    if app.platform == "windows" and ui.active_window().rect.contains(x, y):
        return ui.active_window()

    for window in ui.windows():
        if window.rect.contains(x, y):
            return window

    return None
