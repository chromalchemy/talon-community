
#switches to last/next app whether inside or outside current app
#using #btt implementation (over alt-tab, which was glitching)
[go] (last | back | next | swap | jug | juggle | flip | snap) win | win (last | back | next | swap | jug | juggle | flip | snap): 
    key(alt-tab)

(window | win) close: app.window_close()
(window | win) hide: app.window_hide()

## ++++++++++++++++ switch in-app windows .

^window (new | open): app.window_open()
(new | open) window$: app.window_open()

app (window | win) next | next app win: app.window_next()
app (window | win) last | last app win: app.window_previous()

## +++++++++++++++++++++ switch app .

# following only works on windows. Can't figure out how to make it work for mac. No idea what the equivalent for linux would be.
focus$: user.switcher_menu()

# should be a picker
#Switches app, but not sub windows
(go | focus) last app: 
    user.switcher_focus_last()

## trying to open a specific window
# go debug: 
#     user.switch
#     user.switcher_focus_window("Flowstorm Debugger")

(focus | go)  [app] <user.running_applications> [app]: 
    user.switcher_focus(running_applications)

# This doesn't work from another app
# go flow storm:
#     user.switcher_focus_window("Flowstorm debugger")

launch <user.launch_applications>: 
    user.switcher_launch(launch_applications)
    

## +++++++++++++++++++++++++ show running apps in popup .

[help] (list | show) (running | open) apps: 
    user.switcher_toggle_running()

[help] (close | hide) (running | open) apps: 
    user.switcher_hide_running()

#snapping

## ++++++++++++++++++ snap current window to position .

snap <user.window_snap_position>: 
    user.snap_window(window_snap_position)

## ++++++++++++++ snap app to position .
#doesnt bring to front
snap <user.running_applications> <user.window_snap_position>:
    user.snap_app(running_applications, window_snap_position)

snap <user.running_applications> [screen] <number>:
    user.move_app_to_screen(running_applications, number)

## +++++++++++ move to another screen .

snap next [screen]: 
    user.move_window_next_screen()

snap last [screen]: 
    user.move_window_previous_screen()

snap screen <number>: 
    user.move_window_to_screen(number)
