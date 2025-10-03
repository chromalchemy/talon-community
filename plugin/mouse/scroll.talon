
open trackpad scroll [panel]: 
    user.run_raycast_command("pointer control")
    sleep(5000ms)
    key(tab)
    repeat(9)
    sleep(300ms)
    # key(space)                                  

## ++++++++++++++++++++++++++++++ hiss .

# To scroll with a hiss sound, set mouse_enable_hiss_scroll to true in settings.talon
mouse hiss up: user.hiss_scroll_up()
mouse hiss down: user.hiss_scroll_down()

## ++++++++++++++++++ scroll increment .

#down

^((wheel | we'll) down | (tall | (slide | sled )))$: 
    user.mouse_scroll_down()

^((wheel | we'll) down | (tall | (slide | sled ))) [<number>]: 
    user.mouse_scroll_down(number)  

((wheel | we'll) down | (tall | (slide | sled ))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down()

#up 

^((wheel | we'll) up | (sup | (bale | bail | bill)))$: 
    user.mouse_scroll_up()  

^((wheel | we'll) up | (sup | (bale | bail | bill))) [<number>]: 
    user.mouse_scroll_up(number)  

((wheel | we'll) up | (sup | (bale | bail | bill))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up()

## ++++++++++++++++++++++++++++++ tiny .


#down  
  
((wheel | we'll) (tiny | small | bit) down | (tiny | small | bit) (tall | (slide | sled ))) [<number>]:
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_down(na)

((wheel | we'll) (tiny | small | bit) down | (tiny | small | bit) (tall | (slide | sled ))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(0.2)

#up

((wheel | we'll) (tiny | small | bit) up | (tiny | small | bit) (sup | (bale | bail | bill))) [<number>]:
    n = number or 4
    na = 0.1 * n 
    user.mouse_scroll_up(na)

((wheel | we'll) (tiny | small | bit) up | (tiny | small | bit) (sup | (bale | bail | bill))) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(0.2)


## ++++++++++++++++++ max, all the way .

#down

(wheel | we'll) ((max | all) down | bottom) | (tall | (slide | sled)) (max | all | bottom):
    user.mouse_scroll_down(50.0)

((wheel | we'll) ((max | all) down | bottom ) | (tall | (slide | sled )) (max | all | bottom)) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(50.0)

#up 

(wheel | we'll) ((max | all) up  | top) | (sup | (bale | bail | bill)) (max | all | top):

    user.mouse_scroll_up(50.0)

(((wheel | we'll) ((max | all) up  | top) | (sup | (bale | bail | bill))) (max | all | top)) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(50.0)

## ++++++++++++++++++++++++  continuous 

(wheel | we'll) {user.continuous_scrolling_direction}: 
    user.mouse_scroll_continuous(continuous_scrolling_direction)

(wheel | we'll) {user.continuous_scrolling_direction} <number_small>: 
    user.mouse_scroll_continuous(continuous_scrolling_direction, number_small)

(wheel | we'll) {user.continuous_scrolling_direction} here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_continuous(continuous_scrolling_direction)

(wheel | we'll) {user.continuous_scrolling_direction} here <number_small>:
    user.mouse_move_center_active_window()
    user.mouse_scroll_continuous(continuous_scrolling_direction, number_small)
    
## ++++++++++++++++++++++++++++++ stop .

(wheel | we'll) (stop  | stopper | dapper | stop it): 
    user.mouse_scroll_stop()

[(wheel | we'll)] (stop  | stopper | dapper | stop it) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_stop()
    
## ++++++++++++++++++++++++ right/left .

#left

(wheel | we'll) left [<number>]: 
    user.mouse_scroll_right(number or 1)

[(wheel | we'll)] left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right(1)

[(wheel | we'll)] (tiny | small | bit) left: 
    user.mouse_scroll_right(0.5)

[(wheel | we'll)] (tiny | small | bit) left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right(0.5)

(wheel | we'll | scroll | roll) left back: 
    user.mouse_scroll_right(1000)

#right


(wheel | we'll) (right | write) [<number>]: 
    user.mouse_scroll_left(number or 1)

[(wheel | we'll)] (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left(0.5)

[(wheel | we'll)] (tiny | small | bit) (right | write): 
    user.mouse_scroll_left(0.5)

[(wheel | we'll)] (tiny | small | bit) (right | write) here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left(0.5)

(wheel | we'll | scroll | roll) right end: 
    user.mouse_scroll_left(1000)

## ++++++++++++++++++++++++++++++ gaze .

[(wheel | we'll)] gaze scroll: user.mouse_gaze_scroll()

[(wheel | we'll)] gaze scroll here:
    user.mouse_move_center_active_window()
    user.mouse_gaze_scroll()

## ++++++++++++++++++++ homerow scroll .

home scroll: 
    key(cmd-shift-j)

# scroll keys don't work in scroll focused window
# todo: use nriley homerow code to lock in context

home up: 
    key(k)

home down:
    key(j)

home down <number>:
    key(cmd-shift-j)
    sleep(500ms)
    key("j:{number}")

## +++++++++++++++ swift impementation .


## ++++++++++++++++++++++++  swift continuous scroll

[(smooth | flow | slow | float | scroll)] {user.continuous_scrolling_direction}: 
    user.smooth_scroll_continuous(continuous_scrolling_direction)

[(smooth | flow | slow | float | scroll)] {user.continuous_scrolling_direction} <number>: 
    user.smooth_scroll_continuous(continuous_scrolling_direction, number)
    
[(smooth | flow | slow | float | scroll)] (stop | stopper | stop her | dapper | stop it) | halt: 
    user.smooth_scroll_stop()

    