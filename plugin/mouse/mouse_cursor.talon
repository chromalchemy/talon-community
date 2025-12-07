tag: user.mouse_cursor_commands_enable
-
^(curse | cursor) (yes | on | show)$: 
    user.mouse_cursor_show()

^(curse | cursor) (no | off | hide)$: 
    user.mouse_cursor_hide()
