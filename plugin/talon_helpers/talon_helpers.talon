
(talon | tellin | tell in | tallin | talent) [voice] check [for] updates: 
    menu.check_for_updates()

[(open | view | show)] (talon | tellin | tell in | tallin | talent) [voice] [show]  log: 
    menu.open_log()

key(cmd-ctrl-alt-shift-d): menu.open_log()

(talon | tellin | tell in | tallin | talent) [voice] [(show | open)] (rebel | repl): 
    menu.open_repl()

(talon | tellin | tell in | tallin | talent) [voice] home: 
    menu.open_talon_home()

(talon | tellin | tell in | tallin | talent) [voice] copy context pie: 
    user.talon_add_context_clipboard_python()

(talon | tellin | tell in | tallin | talent) [voice] copy context: 
    user.talon_add_context_clipboard()

(talon | tellin | tell in | tallin | talent) [voice] copy name:
    name = app.name()
    clip.set_text(name)

(talon | tellin | tell in | tallin | talent) [voice] copy executable:
    executable = app.executable()
    clip.set_text(executable)

(talon | tellin | tell in | tallin | talent) [voice] copy bundle:
    bundle = app.bundle()
    clip.set_text(bundle)

(talon | tellin | tell in | tallin | talent) [voice] copy title:
    title = win.title()
    clip.set_text(title)

(talon | tellin | tell in | tallin | talent) [voice] dump version:
    result = user.talon_version_info()
    print(result)

(talon | tellin | tell in | tallin | talent) [voice] insert version:
    result = user.talon_version_info()
    user.paste(result)

(talon | tellin | tell in | tallin | talent) [voice] dump context:
    result = user.talon_get_active_context()
    print(result)

## +++++++++++++++++++++++++++ Testing .

^(talon | tellin | tell in | tallin | talent) [voice] (test | tests | sim | simulate)  last$:
    phrase = user.history_get(1)
    user.talon_sim_phrase(phrase)

^(talon | tellin | tell in | tallin | talent) [voice] [(test | tests | sim | simulate)] log last$:
    phrase = user.history_get(1)
    user.talon_sim_phrase(phrase)
    menu.open_log()
    
# test nth back command
^(talon | tellin | tell in | tallin | talent) [voice] (test | tests | sim | simulate) (numb | number) <number_small>$:
    phrase = user.history_get(number_small)
    user.talon_sim_phrase(phrase)

^(talon | tellin | tell in | tallin | talent) [voice] [(test | tests | sim | simulate)] log (numb | number) <number_small>$:
    phrase = user.history_get(number_small)
    user.talon_sim_phrase(phrase)
    menu.open_log()

^(talon | tellin | tell in | tallin | talent) [voice]  (test | tests | sim | simulate)  <phrase>$: user.talon_sim_phrase(phrase)

^(talon | tellin | tell in | tallin | talent) [voice] [(test | tests | sim | simulate)] log <phrase>$: 
    user.talon_sim_phrase(phrase)
    menu.open_log()

## +++++++++++++++++++++++++++++ debug .

^(talon | tellin | tell in | tallin | talent) [voice] debug action {user.talon_actions}$:
    user.talon_action_find("{user.talon_actions}")

^(talon | tellin | tell in | tallin | talent) [voice] debug list {user.talon_lists}$: user.talon_debug_list(talon_lists)
^(talon | tellin | tell in | tallin | talent) [voice] copy list {user.talon_lists}$: user.talon_copy_list(talon_lists)

^(talon | tellin | tell in | tallin | talent) [voice] debug tags$: user.talon_debug_tags()
^(talon | tellin | tell in | tallin | talent) [voice] debug modes$: user.talon_debug_modes()
^(talon | tellin | tell in | tallin | talent) [voice] debug scope {user.talon_scopes}$: user.talon_debug_scope(talon_scopes)
^(talon | tellin | tell in | tallin | talent) [voice] debug setting {user.talon_settings}$: user.talon_debug_setting(talon_settings)
^(talon | tellin | tell in | tallin | talent) [voice] debug all settings$: user.talon_debug_all_settings()

^(talon | tellin | tell in | tallin | talent) [voice] debug active app$:
    result = user.talon_get_active_application_info()
    print("**** Dumping active application **** ")
    print(result)
    print("***********************")

^(talon | tellin | tell in | tallin | talent) [voice] copy active app$:
    result = user.talon_get_active_application_info()
    clip.set_text(result)

^(talon | tellin | tell in | tallin | talent) [voice] create app context$: user.talon_create_app_context()
^(talon | tellin | tell in | tallin | talent) [voice] create windows app context$: user.talon_create_app_context("win")
^(talon | tellin | tell in | tallin | talent) [voice] create linux app context$: user.talon_create_app_context("linux")
^(talon | tellin | tell in | tallin | talent) [voice] create mac app context$: user.talon_create_app_context("mac")
    

^(talon | tellin | tell in | tallin | talent) [voice] (bug report | report bug):
    user.open_url("https://github.com/(talon | tellin | tell in | tallin | talent) [voice]hub/community/issues")

    