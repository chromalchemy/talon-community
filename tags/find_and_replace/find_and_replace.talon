tag: user.find_and_replace
-
tag(): user.clipboard_manager
tag(): user.find


## ++++++++++++++++++++++ find in file .

hunt ([in] this | in file): edit.find("")

hunt ([in] this | in file) (pace | paste):
    edit.find("")
    sleep(25ms)
    edit.paste()

hunt ([in] this | in file) <user.text>: edit.find(text)

## ++++++++++++++++++++++ find in project .

hunt all [<user.text>]: 
    user.find_everywhere("{text or ''}")

hunt all (pace | paste):
    user.find_everywhere("")
    sleep(25ms)
    edit.paste()

## ++++++++++++++ search text settings .

hunt case: user.find_toggle_match_by_case()
hunt word: user.find_toggle_match_by_word()
hunt expression: user.find_toggle_match_by_regex()

## ++++++++++++++++++ navigate results .

hunt next: edit.find_next()
hunt (previous | last | prev): edit.find_previous()

## ++++++++++++++++++ replace and file .


#test selected text capture
# duck text:
#     s = edit.selected_text() 
#     key(enter)
#     insert(s)

replace ([in] this | in file) [<user.text>]:
    user.replace(text or "")

#paste replacement text
replace ([in] this | in file) with (pace | paste) [<user.text>]: 
    user.replace(text or "")
    edit.paste()

# multiline working in vscode    
# replace multi: 
#     edit.copy()
#     user.replace("")
#     edit.paste()
#     key(tab)
#     sleep(200ms)
#     insert("hello")
#     sleep(200ms)
#     user.clipboard_manager_paste(["1"])

## +++ replace selected text with same .
# (for further editing)

#selected text
replace ([in] this | in file) [with] (same | clone):
    s = edit.selected_text()
    user.replace("")
    insert(s)

#spoken text
replace ([in] this | in file) [with] (same | clone) <user.text>:
    user.replace(text)
    key(tab cmd-a delete)
    insert(text)

replace ([in] this | in file) point:
    key(shift:down)
    mouse_click(0) 
    user.replace("")

replace ([in] this | in file) (pace | paste): 
    user.replace("")
    sleep(25ms)
    edit.paste()

## ++++++++++++++++ replace everywhere .

replace [in] all [<user.text>]: user.replace_everywhere("{text or ''}")

replace [in] all (pace | paste):
    user.replace_everywhere("")
    sleep(25ms)
    edit.paste()

## +++++++++++++++ confirm replacement .

replace confirm that: user.replace_confirm()
replace confirm all: user.replace_confirm_all()

#---------quick replace commands, modeled after jetbrains


## +++++++++++++++++++++ clear results .

clear last <user.text> [over]:
    user.select_previous_occurrence(text)
    sleep(100ms)
    edit.delete()

clear next <user.text> [over]:
    user.select_next_occurrence(text)
    sleep(100ms)
    edit.delete()

clear last clip:
    user.select_previous_occurrence(clip.text())
    edit.delete()

clear next clip:
    user.select_next_occurrence(clip.text())
    sleep(100ms)
    edit.delete()

## +++++++++++++++++++ comment results .

comment last <user.text> [over]:
    user.select_previous_occurrence(text)
    sleep(100ms)
    code.toggle_comment()

comment last clip:
    user.select_previous_occurrence(clip.text())
    sleep(100ms)
    code.toggle_comment()

comment next <user.text> [over]:
    user.select_next_occurrence(text)
    sleep(100ms)
    code.toggle_comment()

comment next clip:
    user.select_next_occurrence(clip.text())
    sleep(100ms)
    code.toggle_comment()

## +++++++++++++++++++++ go to results .

go last <user.text> [over]:
    user.select_previous_occurrence(text)
    sleep(100ms)
    edit.right()

go last clip:
    user.select_previous_occurrence(clip.text())
    sleep(100ms)
    edit.right()

go next <user.text> [over]:
    user.select_next_occurrence(text)
    edit.right()

go next clip:
    user.select_next_occurrence(clip.text())
    edit.right()

## ++++++++++++++++ paste over results .

paste last <user.text> [over]:
    user.select_previous_occurrence(text)
    sleep(100ms)
    edit.right()
    edit.paste()

paste next <user.text> [over]:
    user.select_next_occurrence(text)
    sleep(100ms)
    edit.right()
    edit.paste()

replace last <user.text> [over]:
    user.select_previous_occurrence(text)
    sleep(100ms)
    edit.paste()

replace next <user.text> [over]:
    user.select_next_occurrence(text)
    sleep(100ms)
    edit.paste()

## ++++++++++++++++++++ select results .

select last <user.text> [over]: user.select_previous_occurrence(text)
select next <user.text> [over]: user.select_next_occurrence(text)

select last clip: user.select_previous_occurrence(clip.text())
select next clip: user.select_next_occurrence(clip.text())
