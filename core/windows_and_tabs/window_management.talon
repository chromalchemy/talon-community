
## ++++ swap app (not necessarily window) .

# should be a picker?
[(go | focus)] (last | next | back) app | swap app: 
    user.switcher_focus_last()

## ++++++++++++++++++++ swap among all app windows

#switches to last/next app whether inside or outside current app
#using #btt implementation (over alt-tab, which was glitching)
[go] (last | back | next | swap | jug | juggle | flip | snap) (window | win) | (window | win) (last | back | next | swap | jug | juggle | flip | snap): 
    key(alt-tab)

## ++++++++++++++++ switch in-app windows .

app (window | win) next | next app win: app.window_next()
app (window | win) last | last app win: app.window_previous()

## +++++++++++++++++++++ switch app menu (broken on mac).

# following only works on windows. Can't figure out how to make it work for mac. No idea what the equivalent for linux would be.
focus$: user.switcher_menu()

## +++++++++++ go directly to open app .

## trying to open a specific window
# go debug: 
#     user.switch
#     user.switcher_focus_window("Flowstorm Debugger")

(focus | go | ghost)  [app] <user.running_applications> [app]: 
    user.switcher_focus(running_applications)

# This doesn't work from another app needs a window object, not string
# go flow storm:
#     user.switcher_focus_window("Flowstorm debugger")

# go tiki:
    # user.switcher_focus_window("Talon Log")

## +++++++++ hide or close open window .

#how does this compare w axkit?
# todo broken?
(window | win) close: app.window_close()
(window | win) hide: app.window_hide()

## +++++++++++++++++++ open closed app .

launch <user.launch_applications>: 
    user.switcher_launch(launch_applications)
    

## +++++++++++++++++++++++++ show running app names in talon help popup .

[help] [(list | show)] (running | open) (apps | applications): 
    user.switcher_toggle_running()

[help] (close | hide) (running | open) (apps | applications): 
    user.switcher_hide_running()


## +++++++ new window (in current app) .

^window (new | open): app.window_open()
(new | open) window$: app.window_open()


#snapping

## ++++++++++++++++++ snap current window to position .

snap <user.window_snap_position>: 
    user.snap_window(window_snap_position)

## ++++++++++++++ snap app to position .

#doesnt bring to front
snap <user.running_applications> <user.window_snap_position>:
    user.snap_app(running_applications, window_snap_position)

# <user.running_applications> is here twice to require at least two applications.
snap <user.window_split_position> <user.running_applications> <user.running_applications>+:
    user.snap_layout(window_split_position, running_applications_list)

## +++++++++++ move to another screen .

snap next [screen]: 
    user.move_window_next_screen()

snap last [screen]: 
    user.move_window_previous_screen()

## ++++++++++ snap to screen by number .

snap [screen] <number>: 
    user.move_window_to_screen(number)

snap [screen] <number> <user.window_snap_position>: 
    user.move_window_to_screen(number)
    user.snap_window(window_snap_position)

snap <user.running_applications> [screen] <number>:
    user.move_app_to_screen(running_applications, number)

snap <user.running_applications> [screen] <number> <user.window_snap_position>:
    user.move_app_to_screen(running_applications, number)
    user.snap_app(running_applications, window_snap_position)

## ++++++ snap with explict sreen name .

# print screen number {user.ryan.display.display_number.list}: 
#     print("{user.ryan.display.display_number.list}")

snap {user.ryan.display.display_number.list} [screen]: 
    number = user.string_to_int(user.ryan.display.display_number.list)
    user.move_window_to_screen(number)

snap {user.ryan.display.display_number.list} [screen] <user.window_snap_position>: 
    number = user.string_to_int(user.ryan.display.display_number.list)
    user.move_window_to_screen(number)
    user.snap_window(window_snap_position)

snap <user.running_applications> {user.ryan.display.display_number.list} [screen]:
    number = user.string_to_int(user.ryan.display.display_number.list)
    user.move_app_to_screen(running_applications, number)
    
snap <user.running_applications> {user.ryan.display.display_number.list} [screen] <user.window_snap_position>:
    number = user.string_to_int(user.ryan.display.display_number.list)
    user.move_app_to_screen(running_applications, number)
    user.snap_app(running_applications, window_snap_position)
