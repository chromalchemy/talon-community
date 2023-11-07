^window (new | open): app.window_open()
(new | open) window$: app.window_open()
# app (window | win) next: app.window_next()
# app (window | win) last: app.window_previous()
(window | win) close: app.window_close()
(window | win) hide: app.window_hide()

#switching
(focus | go) <user.running_applications>: user.switcher_focus(running_applications)

# following only works on windows. Can't figure out how to make it work for mac. No idea what the equivalent for linux would be.
focus$: user.switcher_menu()

# should be a picker
running (list | open | show) | list [open] apps | open (app | apps) [list] | help show running: user.switcher_toggle_running()
running (close | hide) | close [open] (apps | app) list | help hide: user.switcher_hide_running()

launch <user.launch_applications>: user.switcher_launch(launch_applications)

#snapping
snap <user.window_snap_position>: user.snap_window(window_snap_position)
snap next [screen]: user.move_window_next_screen()
snap last [screen]: user.move_window_previous_screen()
snap screen <number>: user.move_window_to_screen(number)
snap <user.running_applications> <user.window_snap_position>:
    user.snap_app(running_applications, window_snap_position)
snap <user.running_applications> [screen] <number>:
    user.move_app_to_screen(running_applications, number)
