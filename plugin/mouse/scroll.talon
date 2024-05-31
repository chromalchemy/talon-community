
## ++++++++++++++++++++++++++++++ hiss .

# To scroll with a hiss sound, set mouse_enable_hiss_scroll to true in settings.talon
mouse hiss up: user.hiss_scroll_up()
mouse hiss down: user.hiss_scroll_down()

## ++++++++++++++++++ scroll increment .

#down

^((wheel | we'll) down | (tall | (slide | sled | slit)))$: 
    user.mouse_scroll_up(1)

^((wheel | we'll) down | (tall | (slide | sled | slit))) [<number>]: 
    user.mouse_scroll_up(number)  

((wheel | we'll) down | (tall | (slide | sled | slit))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up()

#up 

^((wheel | we'll) up | (sup | (bale | bail | bill)))$: 
    user.mouse_scroll_down(1)  

^((wheel | we'll) up | (sup | (bale | bail | bill))) [<number>]: 
    user.mouse_scroll_down(number)  

((wheel | we'll) up | (sup | (bale | bail | bill))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down()

## ++++++++++++++++++++++++++++++ tiny .


#down  

((wheel | we'll) (tiny | small) down | (tiny | small) (tall | (slide | sled | slit))) [<number>]:
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_up(na)

((wheel | we'll) (tiny | small) down | (tiny | small) (tall | (slide | sled | slit))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(0.2)

#up

(wheel | we'll) (tiny | small) up | (tiny | small) (sup | (bale | bail | bill)):
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_down(na)

(wheel | we'll) (tiny | small) up | (tiny | small) (sup | (bale | bail | bill)) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(0.2)


## ++++++++++++++++++ max, all the way .

#down

(wheel | we'll) (max | all) down | (tall | (slide | sled | slit)) (max | all):
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(30.0)

((wheel | we'll) (max | all) down | (tall | (slide | sled | slit)) (max | all)) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(30.0)

#up 
((wheel | we'll) (max | all) up | (sup | (bale | bail | bill))) (max | all):
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(50.0)

((wheel | we'll) (max | all) up | (sup | (bale | bail | bill))) (max | all) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(50.0)

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

## ++++++++++++++++++++++++++++++ stop .

^[(wheel | we'll | flow)] (stop  | stopper | stop it) [(wheel | we'll | flow)]$: 
    user.mouse_scroll_stop()

[(wheel | we'll | flow)] (stop | stopper | stop it) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_stop()
    
## ++++++++++++++++++++++++ right/left .

#left

(wheel | we'll) left [<number>]: 
    user.mouse_scroll_right(number or 1)

[(wheel | we'll)] left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right()

[(wheel | we'll)] (tiny | small) left: 
    user.mouse_scroll_right(0.5)

[(wheel | we'll)] (tiny | small) left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right(0.5)

#right

(wheel | we'll) (right | write) [<number>]: 
    user.mouse_scroll_left(number or 1)

[(wheel | we'll)] (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left()

[(wheel | we'll)] (tiny | small) (right | write): 
    user.mouse_scroll_left(0.5)

[(wheel | we'll)] (tiny | small) (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left(0.5)

## ++++++++++++++++++++++++++++++ gaze .

[(wheel | we'll)] gaze: user.mouse_gaze_scroll()

[(wheel | we'll)] gaze here:
    user.mouse_move_center_active_window()
    user.mouse_gaze_scroll()
