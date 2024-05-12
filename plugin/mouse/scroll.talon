
^(wheel | we'll) down [<number>]: 
    user.mouse_scroll_up(number or 1)  
    
^(wheel | we'll) up [<number>]: 
    user.mouse_scroll_down(number or 1)  

[(wheel | we'll)] down here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up()

[(wheel | we'll)] up here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down()

[(wheel | we'll)] (tiny | small) down [<number>]:
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_up(na)

[(wheel | we'll)] (tiny | small) up:
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_down(na)

[(wheel | we'll)] (tiny | small) down here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(0.2)

[(wheel | we'll)] (tiny | small) up here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(0.2)

## ++++++++++++++++++++++++ continuous .

[(wheel | we'll)] flow down [<number>]: 
    user.mouse_scroll_up_continuous(number or 1)

[(wheel | we'll)] flow up [<number>]: 
    user.mouse_scroll_down_continuous(number or 1)

[(wheel | we'll)] flow down here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up_continuous()

[(wheel | we'll)] flow up here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down_continuous()

^[(wheel | we'll | flow)] (stop  | stopper | stop it) [(wheel | we'll | flow)]$: 
    user.mouse_scroll_stop()

[(wheel | we'll | flow)] (stop | stopper | stop it) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_stop()
    
## ++++++++++++++++++++++++ right/left .

(wheel | we'll) left [<number>]: 
    user.mouse_scroll_right(number or 1)

(wheel | we'll) (right | write) [<number>]: 
    user.mouse_scroll_left(number or 1)

[(wheel | we'll)] left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right()

[(wheel | we'll)] (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left()

[(wheel | we'll)] (tiny | small) left: 
    user.mouse_scroll_right(0.5)

[(wheel | we'll)] (tiny | small) (right | write): 
    user.mouse_scroll_left(0.5)

[(wheel | we'll)] (tiny | small) left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right(0.5)

[(wheel | we'll)] (tiny | small) (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left(0.5)

## ++++++++++++++++++++++++++++++ gaze .

[(wheel | we'll)] gaze: user.mouse_gaze_scroll()

[(wheel | we'll)] gaze here:
    user.mouse_move_center_active_window()
    user.mouse_gaze_scroll()
