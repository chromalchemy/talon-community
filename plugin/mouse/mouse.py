from dataclasses import dataclass

from talon import Context, Module, actions, app, ctrl, settings, ui

mod = Module()
ctx = Context()

mod.list(
    "mouse_button",
    desc="List of mouse button words to mouse_click index parameter",
)
mod.setting(
    "mouse_enable_pop_click",
    type=int,
    default=0,
    desc="Pop noise clicks left mouse button. 0 = off, 1 = on with eyetracker but not with zoom mouse mode, 2 = on but not with zoom mouse mode",
)
mod.setting(
    "mouse_enable_pop_stops_scroll",
    type=bool,
    default=False,
    desc="When enabled, pop stops continuous scroll modes (wheel upper/downer/gaze)",
)
mod.setting(
    "mouse_enable_pop_stops_drag",
    type=bool,
    default=False,
    desc="When enabled, pop stops mouse drag",
)
mod.setting(
    "mouse_wake_hides_cursor",
    type=bool,
    default=False,
    desc="When enabled, mouse wake will hide the cursor. mouse_wake enables zoom mouse.",
)


@dataclass(slots=True)
class EyeTrackingState:
    """Eye tracking state that can be queried with tracking.*_enabled actions
    This is cached on the user.mouse_sleep action so the state can be restored on the user.mouse_wake action.
    """

    control_zoom: bool
    control: bool
    control1: bool


eye_tracking_state: EyeTrackingState


def on_ready():
    global eye_tracking_state
    eye_tracking_state = EyeTrackingState(
        actions.tracking.control_zoom_enabled(),
        actions.tracking.control_enabled(),
        actions.tracking.control1_enabled(),
    )


app.register("ready", on_ready)


@mod.action_class
class Actions:
    def zoom_close():
        """Closes an in-progress zoom. Talon will move the cursor position but not click."""
        actions.user.deprecate_action(
            "2024-12-26",
            "user.zoom_close",
            "tracking.zoom_cancel",
        )
        actions.tracking.zoom_cancel()

    def zoom_overlay() -> None:
        """Open the zoom mouse overlay (capture screen region) using Talon's built-in zoom mouse."""
        try:
            actions.tracking.control_zoom_toggle(True)
        except Exception:
            pass

        try:
            from talon.plugins import eye_zoom_mouse

            try:
                print(
                    "user.zoom_overlay: enabled=",
                    getattr(eye_zoom_mouse.zoom_mouse, "enabled", None),
                    "state=",
                    getattr(eye_zoom_mouse.zoom_mouse, "state", None),
                )
            except Exception:
                pass

            try:
                if hasattr(eye_zoom_mouse, "toggle_zoom_mouse"):
                    eye_zoom_mouse.toggle_zoom_mouse(True)
            except Exception:
                pass

            if not eye_zoom_mouse.zoom_mouse.enabled:
                eye_zoom_mouse.zoom_mouse.enable()
            eye_zoom_mouse.zoom_mouse.capture()

            try:
                print(
                    "user.zoom_overlay after capture: enabled=",
                    getattr(eye_zoom_mouse.zoom_mouse, "enabled", None),
                    "state=",
                    getattr(eye_zoom_mouse.zoom_mouse, "state", None),
                )
            except Exception:
                pass

            try:
                if eye_zoom_mouse.zoom_mouse.state == eye_zoom_mouse.STATE_IDLE:
                    actions.tracking.zoom()
            except Exception:
                pass
        except Exception as e:
            print(f"user.zoom_overlay failed: {e}")

    def mouse_wake():
        """Re-enable eye tracking state and disables cursor"""
        # restore eye tracking modes enabled as of the last user.mouse_sleep
        if eye_tracking_state.control_zoom:
            actions.tracking.control_zoom_toggle(True)
        if eye_tracking_state.control:
            actions.tracking.control_toggle(True)
        if eye_tracking_state.control1:
            actions.tracking.control1_toggle(True)

        if settings.get("user.mouse_wake_hides_cursor"):
            actions.user.mouse_cursor_hide()

    def mouse_drag(button: int):
        """Press and hold/release a specific mouse button for dragging"""
        # Clear any existing drags
        actions.user.mouse_drag_end()

        # Start drag
        actions.mouse_drag(button)

    def mouse_drag_end() -> bool:
        """Releases any held mouse buttons"""
        buttons = ctrl.mouse_buttons_down()
        if buttons:
            for button in buttons:
                actions.mouse_release(button)
            return True
        return False

    def mouse_drag_toggle(button: int):
        """If the button is held down, release the button, else start dragging"""
        if button in ctrl.mouse_buttons_down():
            actions.mouse_release(button)
        else:
            actions.mouse_drag(button)

    def mouse_sleep():
        """Disables control mouse, zoom mouse, and re-enables cursor"""
        # save eye tracking state so it can be restored on user.mouse_wake
        global eye_tracking_state
        eye_tracking_state.control_zoom = actions.tracking.control_zoom_enabled()
        eye_tracking_state.control = actions.tracking.control_enabled()
        eye_tracking_state.control1 = actions.tracking.control1_enabled()

        actions.tracking.control_zoom_toggle(False)
        actions.tracking.control_toggle(False)
        actions.tracking.control1_toggle(False)

        actions.user.mouse_cursor_show()
        actions.user.mouse_scroll_stop()
        actions.user.mouse_drag_end()

    def copy_mouse_position():
        """Copy the current mouse position coordinates"""
        x, y = actions.mouse_x(), actions.mouse_y()
        actions.clip.set_text(f"{x}, {y}")

    def mouse_move_center_active_window():
        """Move the mouse cursor to the center of the currently active window"""
        rect = ui.active_window().rect
        actions.mouse_move(rect.center.x, rect.center.y)


@ctx.action_class("user")
class UserActions:
    def noise_trigger_pop():
        dont_click = False

        # Allow pop to stop drag
        if settings.get("user.mouse_enable_pop_stops_drag"):  # noqa: SIM102
            if actions.user.mouse_drag_end():
                dont_click = True

        # Allow pop to stop scroll
        if settings.get("user.mouse_enable_pop_stops_scroll"):  # noqa: SIM102
            if actions.user.mouse_scroll_stop():
                dont_click = True

        if dont_click:
            return

        # Otherwise respect the mouse_enable_pop_click setting
        setting_val = settings.get("user.mouse_enable_pop_click")

        is_using_eye_tracker = (
            actions.tracking.control_zoom_enabled()
            or actions.tracking.control_enabled()
            or actions.tracking.control1_enabled()
        )

        is_zoom_overlay_active = False
        if actions.tracking.control_zoom_enabled():
            try:
                from talon.plugins import eye_zoom_mouse

                is_zoom_overlay_active = (
                    eye_zoom_mouse.zoom_mouse.state == eye_zoom_mouse.STATE_OVERLAY
                )
            except Exception:
                pass

        should_click = (setting_val == 2) or (setting_val == 1 and is_using_eye_tracker)

        if should_click and not is_zoom_overlay_active:
            actions.mouse_click()
