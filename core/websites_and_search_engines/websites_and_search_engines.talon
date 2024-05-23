# tag: browser
# -

tag(): user.rango_direct_clicking


(open [in] new [(tab | page)] | new tab) {user.website}: 
    user.open_url(website)

(go | open | hope in) [(tab | page)] {user.website} [again]:
    user.switcher_focus("Google Chrome")
    sleep(300ms)
    user.rango_command_without_target("focusOrCreateTabByUrl", website)

open [in] [new] [(tab | page)] that: 
    user.open_url(edit.selected_text())
    
open [in] [new] [(tab | page)] paste: 
    user.open_url(clip.text())

## +++++++++++++++++++++++ search page .

hunt {user.website} [<user.text>]:
    user.open_url(website)
    sleep(2000ms)
    user.rango_run_action_on_reference("focusElement", "search")
    insert("{text or ''}")

# reuse tab if exists

hunt {user.website} [<user.text>] again:
    user.switcher_focus("Google Chrome")
    sleep(300ms)
    user.rango_command_without_target("focusOrCreateTabByUrl", website)
    sleep(2000ms)
    user.rango_run_action_on_reference("focusElement", "search")
    sleep(100ms)
    edit.select_all()
    insert("{text or ''}")



hunt {user.website} (paste | pace):
    user.switcher_focus("Google Chrome")
    sleep(300ms)
    user.open_url(website)
    sleep(2000ms)
    user.rango_run_action_on_reference("focusElement", "search")
    sleep(100ms)
    edit.select_all()
    edit.paste()
    sleep(200ms)
    key(enter)

hunt {user.website} again (paste | pace):
    user.switcher_focus("Google Chrome")
    sleep(300ms)
    user.rango_command_without_target("focusOrCreateTabByUrl", website)
    sleep(2000ms)
    user.rango_run_action_on_reference("focusElement", "search")
    sleep(100ms)
    edit.select_all()
    edit.paste()
    sleep(200ms)
    key(enter)



## ___________________________________ .

{user.search_engine} hunt <user.text>$:
    user.search_with_search_engine(search_engine, user.text)

{user.search_engine} (that | this):
    text = edit.selected_text()
    user.search_with_search_engine(search_engine, text)

{user.search_engine} paste: 
    user.search_with_search_engine(search_engine, clip.text())
