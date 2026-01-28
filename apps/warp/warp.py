from talon import Context, Module, actions

mod = Module()

mod.apps.warp = """
os: mac
and app.bundle: dev.warp.Warp-Stable
"""


# Declare custom warp actions
@mod.action_class
class UserActions:
    def warp_run_command(cmd_str: str):
        """run a command"""
        actions.insert(cmd_str)
        actions.sleep("200ms")
        actions.key("enter")

    def warp_rename_tab(tab_name: str):
        """Rename the current Warp tab"""

    def warp_run_command_in_new_tab(cmd_str: str, tab_name: str):
        """Run a command in a new Warp tab and rename it"""

    




# Global context for actions that work from anywhere
ctx_global = Context()


@ctx_global.action_class("user")
class GlobalUserActions:
    def warp_run_command_in_new_tab(cmd_str: str, tab_name: str):
        actions.user.switcher_focus("Warp")
        actions.sleep("200ms")
        actions.app.tab_open()
        actions.sleep("2000ms")
        actions.warp_run_command(cmd_str)
        actions.sleep("1000ms")
        actions.user.warp_rename_tab(tab_name)


# Context for Warp-specific actions (when Warp is focused)
ctx = Context()
ctx.matches = r"""
app: warp
"""


@ctx.action_class("user")
class UserActions:
    def tab_jump(number: int):
        if number < 9:
            actions.key(f"cmd-{number}")

    def tab_final():
        actions.key("cmd-9")

    def warp_rename_tab(tab_name: str):
        actions.user.menu_select("Tab|Rename the Current Tab")
        actions.insert(tab_name)
        actions.key("enter")
        actions.sleep("200ms")


@ctx.action_class("edit")
class EditActions:
    def word_left():
        actions.key("alt-left")

    def word_right():
        actions.key("alt-right")
