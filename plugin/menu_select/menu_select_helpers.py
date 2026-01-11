from talon import Module, ui

mod = Module()

@mod.action_class
class Actions:
    def focused_element_safe():
        """Returns the focused UI element if available, None otherwise"""
        try:
            app = ui.active_app()
            if hasattr(app, 'element'):
                focused = app.element.AXFocusedUIElement
                return focused
        except:
            pass
        return None
    
    def ui_element_active_window_or_sheet():
        """Returns the active window or sheet UI element"""
        try:
            app = ui.active_app()
            if hasattr(app, 'element'):
                # Try to get the focused window first
                windows = app.element.children.find(AXRole="AXWindow", visible_only=True)
                if windows:
                    return windows[0]
        except:
            pass
        return None
