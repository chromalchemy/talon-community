import os

from talon import Context, actions, Module

mod = Module()

ctx = Context()

@mod.action_class
class Actions:

    def finder_modal_open_directory(path: str):
        """opens the directory that's already visible in the view"""
        actions.key("cmd-shift-g")
        actions.sleep("500ms")
        actions.insert(path)
        actions.key("enter")
