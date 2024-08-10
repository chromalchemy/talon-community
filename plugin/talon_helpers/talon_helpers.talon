
(talon | tellin | tell in | tallin | talent) [voice] check [for] updates: 
    menu.check_for_updates()

(open | launch) (talon | tellin | tell in | tallin | talent) [voice] [show] (log | love) [tab]: 
    user.talon_open_log_in_warp_window()
    # menu.open_log()


[(go | view | show)] (talon | tellin | tell in | tallin | talent) [voice] [show] (log | love):
    user.talon_focus_warp_talon_log()


key(cmd-ctrl-alt-shift-d): 
    user.talon_focus_warp_talon_log()
    # menu.open_log()

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

^(talon | tellin | tell in | tallin | talent) [voice] [(test | tests | sim | simulate)] (log | love) last$:
    phrase = user.history_get(1)
    user.talon_sim_phrase(phrase)
    user.talon_focus_warp_talon_log()
    # menu.open_log()
    
# test nth back command
^(talon | tellin | tell in | tallin | talent) [voice] (test | tests | sim | simulate) (numb | number) <number_small>$:
    phrase = user.history_get(number_small)
    user.talon_sim_phrase(phrase)

^(talon | tellin | tell in | tallin | talent) [voice] [(test | tests | sim | simulate)] (log | love) (numb | number) <number_small>$:
    phrase = user.history_get(number_small)
    user.talon_sim_phrase(phrase)
    user.talon_focus_warp_talon_log()
    # menu.open_log()

^(talon | tellin | tell in | tallin | talent) [voice]  (test | tests | sim | simulate)  <phrase>$: user.talon_sim_phrase(phrase)

^[(talon | tellin | tell in | tallin | talent)] [voice] [(test | tests | sim | simulate)] (log | love) <phrase>$: 
    # user.talon_focus_warp_talon_log()
    # sleep(500ms)
    # key(cmd-k)
    # sleep(300ms)
    user.talon_sim_phrase(phrase)
    # menu.open_log()

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

^(talon | tellin | tell in | tallin | talent) [voice] (relaunch  | restart): user.talon_relaunch()


(hunt | hun) (talon | tellin | talin | command | tall and) [<user.text>]:
    user.system_command_nb("code '/Users/ryan/.talon/user/talon-user.code-workspace'")
    sleep(600ms)
    user.vscode("workbench.view.search")
    sleep(200ms)
    insert(text or "")

(hunt | hun) (talon | tellin | talin | command | tall and) (paste | pace):
    user.system_command_nb("code '/Users/ryan/.talon/user/talon-user.code-workspace'")
    sleep(600ms)
    user.vscode("workbench.view.search")
    sleep(200ms)
    edit.paste()

(go | open) [(talon  | talin | tellin)] [voice] abbreviations: 
    key(cmd-p)
    sleep(100ms)
    insert("community/settings/abbreviations.csv")
    sleep(200ms)
    key(enter)
