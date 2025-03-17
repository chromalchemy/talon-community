control mouse: tracking.control_toggle()
control off: user.mouse_sleep()
zoom mouse: tracking.control_zoom_toggle()
camera overlay: tracking.control_debug_toggle()
run calibration: tracking.calibrate()

key(cmd-ctrl-alt-shift-down):
    mouse_scroll(1)

## ++++++++++++++++++++++++++++ clicks .

touch:
    # close zoom if open
    tracking.zoom_cancel()
    mouse_click(0)
    # close the mouse grid if open
    user.grid_close()
    # End any open drags
    # Touch automatically ends left drags so this is for right drags specifically
    user.mouse_drag_end()

righty:
    # close zoom if open
    tracking.zoom_cancel()
    mouse_click(1)
    # close the mouse grid if open
    user.grid_close()

((right | r | are | part) click | (context | see | sea) (click | touch | that | menu | options)):
    mouse_click(1)
    # close the mouse grid if open
    user.grid_close()
    

mid click:
    # close zoom if open
    tracking.zoom_cancel()
    mouse_click(2)
    # close the mouse grid
    user.grid_close()

#see keys.py for modifiers.
#defaults
#command
#control
#option = alt
#shift
#super = windows key
<user.modifiers> touch:
    # close zoom if open
    tracking.zoom_cancel()
    key("{modifiers}:down")
    mouse_click(0)
    key("{modifiers}:up")
    # close the mouse grid
    user.grid_close()

shipped touch:
    key("shift:down")
    mouse_click(0)
    key("shift:up")
    # close the mouse grid
    user.grid_close()
    

<user.modifiers> (righty | right (click | lick | touch)):
    # close zoom if open
    tracking.zoom_cancel()
    key("{modifiers}:down")
    mouse_click(1)
    key("{modifiers}:up")
    # close the mouse grid
    user.grid_close()

duke | (dub | double) (click | lick | touch):
    # close zoom if open
    tracking.zoom_cancel()
    mouse_click()
    mouse_click()
    # close the mouse grid
    user.grid_close()

(trip | triple) (click | lick | touch) :
    # close zoom if open
    tracking.zoom_cancel()
    mouse_click()
    mouse_click()
    mouse_click()
    # close the mouse grid
    user.grid_close()

## ++++++++++++++++++++++++++ dragging .

[left] drag [(lock | start)] :
    # close zoom if open
    tracking.zoom_cancel()
    user.mouse_drag(0)
    # close the mouse grid
    user.grid_close()

(right | righty ) drag [lock]:
    # close zoom if open
    tracking.zoom_cancel()
    user.mouse_drag(1)
    # close the mouse grid
    user.grid_close()
^( end  | drop | release) drag$: user.mouse_drag_end()
^drag (end | drop | release)$: user.mouse_drag_end()
^drop$: user.mouse_drag_end()
    
## +++++++++++++++++++++++++++++++ position

copy mouse position: user.copy_mouse_position()

## ++++++++++++++++++++++++++ my stuff . 

# make percent of screen todo:

(mouse | curse) right [<number>]:
    amount = number or 10
    mouse_nudge(amount, 0)

(mouse | curse) left [<number>]:
    amount = number or 10
    mouse_nudge(user.negative_float(amount), 0)


(mouse | curse) down [<number>]:
    amount = number or 10 
    mouse_nudge(0, amount)

(mouse | curse) up [<number>]:
    amount = number or 10 
    mouse_nudge(0, user.negative_float(amount))

## +++++++++++++++++++++++++ diagnals

(mouse | curse) up right [<number>]:
    amount = number or 10 
    mouse_nudge(amount, user.negative_float(amount))

(mouse | curse) (down right | downright) [<number>]:
    amount = number or 10 
    mouse_nudge(amount, amount)

(mouse | curse) up left [<number>]:
    amount = number or 10 
    mouse_nudge(user.negative_float(amount), user.negative_float(amount))

(mouse | curse) down left [<number>]:
    amount = number or 10 
    mouse_nudge(user.negative_float(amount), amount)

#todo: get this working in finder

#todo: Implement option clicks

## ++++++++++++++++++++++ custom drags .

(option | alt) drag:
    key(alt:down)
    user.mouse_drag(0)
    # sleep(300ms)
    user.grid_close()
    
hold option: key(alt:down)

shift drag:
    key(shift:down)
    # sleep(300ms)
    user.mouse_drag(0)
    user.grid_close()

command drag:
    key(cmd:down)
    user.mouse_drag(0)
    user.grid_close()


curse no:
    # Command added 2021-12-13, can remove after 2022-06-01
    app.notify("Please activate the user.mouse_cursor_commands_enable tag to enable this command")