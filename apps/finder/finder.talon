os: mac
app: finder
-

tag(): user.address
tag(): user.file_manager
tag(): user.navigation
tag(): user.tabs

## +++++++++++++++++++ finder settings .

preferences: key(cmd-,)
options: key(cmd-j)

## +++++++++++++++++++++++ file search .

search: key(cmd-alt-f)

search <user.text>: 
    key(cmd-f)
    sleep(600ms)
    insert(text)

search (name | names | file names) <user.text>: 
    key(cmd-f)
    sleep(500ms)
    insert(text)
    sleep(500ms)
    key(down enter)

# exit search payeahrt and go to navigate file list
go list: 
    user.address_focus()
    sleep(300ms)
    key(esc)

## ++++++++++++++++++++++++ new folder .

new folder: key(cmd-shift-n)

new folder with (files | selection | selected | that): 
    mouse_click(1)
    sleep(300ms)
    insert("new folder with selection")
    key(enter)

new folder with (files | selection | selected | that) <user.text>: 
    mouse_click(1)
    sleep(300ms)
    insert("new folder with selection")
    key(enter)
    sleep(1500ms)
    insert(text)
    sleep(300ms)
    key(enter)


## ++++++++++++++++++++++++++++++ sort files .

# bit of a mouthful, but it's probably not the kind of thing you'd be saying frequently
sort by none: key(ctrl-alt-cmd-0)
sort by name: key(ctrl-alt-cmd-1)
sort by kind: key(ctrl-alt-cmd-2)
sort by date opened: key(ctrl-alt-cmd-3)
sort by date added: key(ctrl-alt-cmd-4)
sort by date modified: key(ctrl-alt-cmd-5)
sort by size: key(ctrl-alt-cmd-6)

## ++++++++++++++++++++++++++++++ view .

show view options: key(cmd-j)

icon view: key(cmd-1)
column view: key(cmd-3)
list view: key(cmd-2)
gallery view: key(cmd-4)

## ++++++++++++++++++++++++++++++ path.

go [to] folder: key(cmd-shift-g)

# is shadowed by copy address
# copy [relative | user] path: key(alt-cmd-c)

copy full [file] path | copy [file] path full:
    key("shift-ctrl-alt-cmd-f")

## ++++++++++++++++++++++++++ filename .

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

copy (whole | full | entire) file name: 
    key(enter)
    sleep(100ms)
    edit.select_all()
    edit.copy()
    key(escape)
    
edit file name | rename file | file rename:
    key(enter)

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

## +++++++++++++++++++++++++++++ trash .

trash it: key(cmd-backspace)

## ++++++++++++++++++ show or hide app .

hide [finder]: key(cmd-h)
hide others: app.window_hide_others()

## ++++++++++++++++++ navigate list .

go top: key(alt-up)
go bottom: key(alt-down)

## +++++++++++++++++++++++++ file tags .

tag [file] <number>: key("ctrl-{number}")
remove [file] tags: key(ctrl-0)

## ++++++++++++++++++++++ hidden files .

(show | hide) (hidden | invisible) files: key(cmd-shift-.)

(show | hide) (hidden | invisible) folders: key(ctrl-shift-period)

## ++++++++++++++++++++++++ open file .

(open | hope in) file: key(cmd-o)

## +++++++++++++++++++++++++++ close .

close | close: key(space)

## +++++++++++++++++++++++++ file info .

(get | file) info: key(cmd-i)



## +++++++++++++++++++++++++ misc .

duplicate file: 
    user.menu_select('File|Duplicate')

rename (file | files):
    user.menu_select('File|Rename…')
    

new (finder | files | file) window:
    user.menu_select('File|New Finder Window')


# my [to] {user.system_paths} [folder]:
#     user.file_manager_open_directory(system_paths)


quick look:
    key(space)