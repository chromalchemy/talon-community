from typing import Optional

from talon import Context, Module, actions

mod = Module()
ctx = Context()

mod.setting(
    "smooth_scroll_speed",
    type=int,
    default=60,
    desc="The default pixels/s used when smooth scrolling continuously",
)

def smooth_scroll_cmd(params: str):
    "run smooth scroll command by piping in data to babashka daemon"
    command_pipe = "/Users/ryan/.talon/user/community/plugin/mouse/scroll-command-pipe"
    actions.user.system_command_nb(f"""echo '{params}' > {command_pipe}""")

def toggle_smooth_scroll_continuous(scroll_dir: str, smooth_scroll_speed: Optional[int] = 60):
    "start scrolling in a direction"
    smooth_scroll_cmd(f"""[:toggle "{scroll_dir}" {smooth_scroll_speed}]""")

@mod.action_class
class Actions:

    def smooth_scroll_continuous(direction: str, speed: Optional[int] = 60):
        "Scrolls continuously in the given direction, while validating direction"
        match direction:
            case "UP":
                toggle_smooth_scroll_continuous("up", speed)
            case "DOWN":
                toggle_smooth_scroll_continuous("down", speed)
            case "LEFT":
                print("no left command")
            case "RIGHT":
                print("no right command")
            case _:
                raise ValueError(f"Invalid continuous scrolling direction: {direction}")

    def smooth_scroll_stop() -> bool:
        "Stops scrolling"
        smooth_scroll_cmd(":stop")
