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

(confirm | complete) [command] | do (it | that): 
    key(right)
    key(enter)

(clear | cancel | quit) command: 
    key(ctrl-c)

run [command] {user.community.apps.warp.bash_commands.list}: 
    user.warp_run_command("{user.community.apps.warp.bash_commands.list}")

go (directory | dir | path) {user.system_paths}:
    cmd = "cd " + "\"{system_paths}\""
    print(cmd) 
    user.warp_run_command(cmd)