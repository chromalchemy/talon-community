os: mac
app: finder
-
tag(): user.file_manager
tag(): user.tabs
preferences: key(cmd-,)
options: key(cmd-j)

search: key(cmd-f)

search <user.text>: 
    key(cmd-f)
    sleep(600ms)
    insert(text)

search (photo shop | photo | photoshop) <user.text>: 
    key(cmd-f)
    sleep(600ms)
    insert(text + " .ps")

search (name | names | file names) <user.text>: 
    key(cmd-f)
    sleep(500ms)
    insert(text)
    sleep(500ms)
    key(down enter)

search (photo shop | photo | photoshop) (name | names | file names) <user.text>: 
    key(cmd-f)
    sleep(500ms)
    insert(text)
    sleep(500ms)
    key(down enter)
    insert(".ps")

go [to] folder: key(cmd-shift-g)

# bit of a mouthful, but it's probably not the kind of thing you'd be saying frequently
sort by none: key(ctrl-alt-cmd-0)
sort by name: key(ctrl-alt-cmd-1)
sort by kind: key(ctrl-alt-cmd-2)
sort by date opened: key(ctrl-alt-cmd-3)
sort by date added: key(ctrl-alt-cmd-4)
sort by date modified: key(ctrl-alt-cmd-5)
sort by size: key(ctrl-alt-cmd-6)

icon view: key(cmd-1)
column view: key(cmd-3)
list view: key(cmd-2)
gallery view: key(cmd-4)

copy path: key(alt-cmd-c)

copy file name: 
    key(enter)
    sleep(100ms)
    edit.copy()
    key(escape)
    
copy file name point: 
    mouse_click(1)
    key(enter)
    sleep(100ms)
    edit.copy()
    key(escape)

copy (whole | full) file name: 
    key(enter)
    sleep(100ms)
    edit.select_all()
    edit.copy()
    key(escape)
    
# buggy
copy (whole | full) file name point: 
    mouse_click(1)
    sleep(500ms)
    key(enter)
    sleep(500ms)
    key(cmd-a)
    sleep(500ms)
    key(cmd-c)
    sleep(500ms)
    key(escape)

trash it: key(cmd-backspace)

hide [finder]: key(cmd-h)
hide others: app.window_hide_others()

show view options: key(cmd-j)

go top: key(alt-up)
go bottom: key(alt-down)

tag [file] <number>: key("ctrl-{number}")
remove [file] tags: key(ctrl-0)

show hidden files: key(cmd-shift-.)
