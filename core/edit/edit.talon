
# Zoom
zoom in: edit.zoom_in()
zoom out: edit.zoom_out()
zoom reset: edit.zoom_reset()

# Searching
find [it]: edit.find()
next (one | result | in page): edit.find_next()

# Navigation

# The reason for these spoken forms is that "page up" and "page down" are globally defined as keys.
page up: edit.page_up()
page down: edit.page_down()

go word left: edit.word_left()
go word right: edit.word_right()

go left: edit.left()
go right: edit.right()
go up: edit.up()
go down: edit.down()

#Does this conflict?
go [line] (start | head): edit.line_start()
go [line] (end | tail): edit.line_end()

go way left:
    edit.line_start()
    edit.line_start()
go way right: edit.line_end()
go way up: edit.file_start()
go way down: edit.file_end()

go top: edit.file_start()
go bottom: edit.file_end()

go page up: edit.page_up()
go page down: edit.page_down()

# Selecting
(select | take) (all | or): 
    edit.select_all()
    key(cmd-a)
select line: edit.select_line()
(select | take) line start: user.select_line_start()
(select | take) line end: user.select_line_end()

select block: edit.select_paragraph()


(select | take) left: edit.extend_left()
(select | take) right: edit.extend_right()
(select | take) up: edit.extend_line_up()
(select | take) down: edit.extend_line_down()

select word: edit.select_word()
(select | take) word left: edit.extend_word_left()
(select | take) word right: edit.extend_word_right()

(select | take) way left: edit.extend_line_start()
(select | take) way right: edit.extend_line_end()
(select | take) way up: edit.extend_file_start()
(select | take) way down: edit.extend_file_end()

(select | take) (Pointer | point):
    key(shift:down)
    mouse_click(0)

# Indentation
indent [more]: edit.indent_more()
(indent less | out dent): edit.indent_less()
dedent | (unindent | un indent) [that]: 
    key(shift-tab)


# Delete
clear all: user.delete_all()
clear line: edit.delete_line()
clear line start: user.delete_line_start()
clear line end: user.delete_line_end()
clear block: edit.delete_paragraph()
clear left: edit.delete()
clear right | delete forward: user.delete_right()

clear up:
    edit.extend_line_up()
    edit.delete()

clear down:
    edit.extend_line_down()
    edit.delete()

clear word: edit.delete_word()

clear word left:
    edit.extend_word_left()
    edit.delete()

clear word right:
    edit.extend_word_right()
    edit.delete()

clear way left:
    edit.extend_line_start()
    edit.delete()

clear way right:
    edit.extend_line_end()
    edit.delete()

clear way up:
    edit.extend_file_start()
    edit.delete()

clear way down:
    edit.extend_file_end()
    edit.delete()

(chuck | crop | clear) (Pointer | point):
    key(shift:down)
    mouse_click(0)
    edit.delete()

(chuck | crop | clear) (Pointer | point) force:
    key(shift:down)
    mouse_click(0)
    edit.delete()
    key(escape)    
    

# Copy
copy [(that | it)]: edit.copy()
copy all: user.copy_all()
copy line: user.copy_line()
copy line start: user.copy_line_start()
copy line end: user.copy_line_end()
copy block: user.copy_paragraph()
copy word: user.copy_word()
copy word left: user.copy_word_left()
copy word right: user.copy_word_right()

copy (Pointer | point):
    key(shift:down)
    mouse_click(0)
    edit.copy()

copy (Pointer | point) force:
    key(shift:down)
    mouse_click(0)
    edit.copy()
    key(escape)
    # cursor go back action

#to do: do we want these variants, seem to conflict
# copy left:
#      edit.extend_left()
#      edit.copy()
# copy right:
#     edit.extend_right()
#     edit.copy()
# copy up:
#     edit.extend_up()
#     edit.copy()
# copy down:
#     edit.extend_down()
#     edit.copy()

# Cut
(carve | cut) [(that | it)]: edit.cut()
(carve | cut) all: user.cut_all()
cut line: user.cut_line()
(carve | cut) line start: user.cut_line_start()
(carve | cut) line end: user.cut_line_end()
cut block: user.cut_paragraph()

cut word: user.cut_word()
(carve | cut) word left: user.cut_word_left()
(carve | cut) word right: user.cut_word_right()

(cut | carve) (Pointer | point):
    key(shift:down)
    mouse_click(0)
    edit.cut()


#to do: do we want these variants
# cut left:
#      edit.select_all()
#      edit.cut()
# cut right:
#      edit.select_all()
#      edit.cut()
# cut up:
#      edit.select_all()
#     edit.cut()
# cut down:
#     edit.select_all()
#     edit.cut()


# Paste

(paste | pace | piss) [(that | it | there | here)]:
     edit.paste()

(paste | pace | piss) enter:
    edit.paste()
    key(enter)

paste match: edit.paste_match_style()

(paste | pace | piss) [and] match [style]: 
    edit.paste_match_style()

(paste | pace | piss) [to] all: 
    user.paste_all()

(paste | pace | piss) [to] line: 
    user.paste_line()

(paste | pace | piss) [to] line start: 
    user.paste_line_start()

(paste | pace | piss) [to] line end: 
    user.paste_line_end()

(pace | paste) [to] block: user.paste_paragraph()

(paste | pace | piss) [to] word: 
    user.paste_word()
   
# Make version that leaves the pasted text selected    
(paste) (Pointer | point):
    key(shift:down)
    mouse_click(0)
    edit.paste()

# Duplication
clone that: edit.selection_clone()
clone line: edit.line_clone()

# Insert new line
new line above: edit.line_insert_up()
new line below | slap: edit.line_insert_down()

# Insert padding with optional symbols
(pad | padding): user.insert_between(" ", " ")
(pad | padding) <user.symbol_key>+:
    insert(" ")
    user.insert_many(symbol_key_list)
    insert(" ")

# Undo/redo
(undo | nope) [that]: edit.undo()
(you do | redo) [that]: edit.redo()

# Save
(file  | i'll) save: edit.save()
(file  | i'll) save all: edit.save_all()

## +++++++++++++++++++ My custom stuff .

(override line | over ride line):
    edit.line_clone()
    sleep(300ms)
    # comment line
    key(up cmd-/) 
    #navigate to place in new line
    key(down left:2) 
    # mimic("go to line start")
    # insert("#")

round (string | rap | wrap | text) <user.prose>:
    insert("({prose}) ")


[go] line mid: user.line_middle()
