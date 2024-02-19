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


## +++ load and search browser history .

(go  | show | search  | hunt) history [<user.text>]: 
    browser.show_history()
    sleep(300ms)
    insert(text)

(go  | show | search  | hunt) history (grouped  | groups) [<user.text>]: 
    browser.go("chrome://history/grouped")
    sleep(300ms)
    insert(text)

## ++++++++++++++++++ open closed tabs .
(open | reopen) [last] (closed | close) tab | tab reopen:
    key(cmd-shift-t)
