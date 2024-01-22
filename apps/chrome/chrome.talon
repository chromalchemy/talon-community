app: chrome
-
tag(): browser
tag(): user.tabs

profile switch: user.chrome_mod("shift-m")

tab (search | list): user.chrome_mod("shift-a")

tab (search | list) <user.text>$:
    user.chrome_mod("shift-a")
    sleep(200ms)
    insert("{text}")
    key(down)

## +++++++++++++++ inspect in devtools .

open inspector | inspect page:
    key(cmd-shift-c)
    
inspect [here]: 
    mouse_click(1)
    sleep(100ms)
    insert("inspect")
    key(enter)
