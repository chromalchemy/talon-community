# toggle "Control Mouse" (newer implementation)

[toggle] control mouse | tracking: 
    tracking.control_toggle()

(track | tracking | tracker | control mouse) on: 
    tracking.control_toggle(true)

[all] (track | tracking | tracker | control mouse) off: 
    tracking.control_toggle(false)

# legacy control mouse
[(toggle | use)] (legacy | old) (control mouse | tracking):
    tracking.control1_toggle()


# Disables control mouse, zoom mouse, and re-enables cursor
control off:  
    user.mouse_sleep()


# this doesnt work, deadlocks
# user.status_menu_select_by_title("Talon")

(tracking | track) left eye [only]:
    user.select_talon_menu_item("Eye Tracking", "Only Left Eye")

(tracking | track) right eye [only]:
    user.select_talon_menu_item("Eye Tracking", "Only Right Eye")

(tracking | track) both (eyes | eye):
    user.select_talon_menu_item("Eye Tracking", "Use Both Eyes")


## ++++++++++++++++++++++++ zoom mouse .

zoom (curse | cursor):
    user.zoom_overlay()

[toggle] zoom mouse | track zoom:
    tracking.control_zoom_toggle()
    
zoom mouse on:
    tracking.control_zoom_toggle(true)

zoom mouse off: 
    tracking.control_zoom_toggle(false)


## +++++++++++++++++ toggle track gaze .

[toggle] gaze [control]: 
    tracking.control_gaze_toggle()

track head | gaze [control] off : 
    tracking.control_gaze_toggle(false)

track gaze | gaze [control] on: 
    tracking.control_gaze_toggle(true)

## +++++++++++++++++ toggle gaze focus .

[toggle] gaze focus: 
    tracking.control_gaze_focus_toggle()

gaze focus off : 
    tracking.control_gaze_focus_toggle(false)

gaze focus on: 
    tracking.control_gaze_focus_toggle(true)

## ++++++++++++++ toggle head tracking .

[toggle] head tracking:
    tracking.control_head_toggle()

head [tracking] on: 
    tracking.control_head_toggle(true)

head [tracking] off: 
    tracking.control_head_toggle(false)

## +++++++++++++++++++++++++ head jump .

jump [(curse | cursor)] | (curse | cursor) jump:
    tracking.jump()


[toggle] head jump: 
    tracking.control_head_jump_toggle()

head jump on: 
    tracking.control_head_jump_toggle(true)

head jump off: 
    tracking.control_head_jump_toggle(false)

## +++++++++++++++++ toggle mouse jump .

[toggle] mouse jump: 
    tracking.control_mouse_jump_toggle()

mouse jump on: 
    tracking.control_mouse_jump_toggle(true)

mouse jump off: 
    tracking.control_mouse_jump_toggle(false)

## +++++++++++++++++ combined modes .

# only mouse jump    
secret [control mouse] mode | mouse jump only:
    tracking.control_gaze_toggle(false)
    tracking.control_head_toggle(false)
    tracking.control_mouse_jump_toggle(true)

all tracking [on] | tracking all:
    tracking.control_toggle(true)
    tracking.control_gaze_toggle(true)
    tracking.control_head_toggle(true)
    tracking.control_head_jump_toggle(true)
    tracking.control_mouse_jump_toggle(true) 

## ++++++++++++++++++++ debug tracking .

[toggle] (camera overlay | (tracking | tracker | track) debug | debug (tracking | tracker)): 
    tracking.control_debug_toggle()

run calibration | calibrate [eye | head] (tracking | tracker): 
    tracking.calibrate()


# Cursor
cursor center:              user.mouse_move_center_window()
cursor print:               print("{mouse_x()}, {mouse_y()}")
cursor copy:                clip.set_text("{mouse_x()}, {mouse_y()}")


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
    

## ++++++++++++++++++++++ custom drags .


#todo: get this working in finder

#todo: Implement option clicks

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
