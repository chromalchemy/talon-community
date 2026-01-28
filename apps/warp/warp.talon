app: warp
-
tag(): terminal
tag(): user.generic_unix_shell
tag(): user.git
tag(): user.kubectl
tag(): user.tabs
tag(): user.file_manager
tag(): user.readline

clear (tab | output | text): 
    key(cmd-k)

new tab: 
    app.tab_open()

(name  | rename | renamed) (tab | tap) <user.text>:
    user.warp_rename_tab(text)

word left: 
    edit.word_left()

word right: 
    edit.word_right()

run: 
    key(enter)

(confirm | complete) [command]: 
    key(right)
    key(enter)

(clear | cancel | quit) command: 
    key(ctrl-c)

