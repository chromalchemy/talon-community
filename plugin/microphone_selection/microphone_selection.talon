^[(talon | talent)] ((mic | mike | mice) | (microphone | like a phone)) (pick | show | select | list)$: 
    user.microphone_selection_toggle()

^pick ((mic | mike | mice) | (microphone | like a phone))$: 
    user.microphone_selection_toggle()

^((mic | mike | mice) | (microphone | like a phone)) (close | clothes)$: 
    user.microphone_selection_hide()

^close (mic | mike) list$: 
    user.microphone_selection_hide()

^((mic | mike | mice) | (microphone | like a phone)) [(choose | pick)] <number_small>$: 
    user.microphone_select(number_small)

# set talon mic 
(set | change) talon ((mic | mike | mice) | (microphone | like a phone)) [to] {user.community.plugin.microphone_selection.microphone.list}: 
    print("manually setting microphone to {user.community.plugin.microphone_selection.microphone.list}")
    sound.set_microphone("{user.community.plugin.microphone_selection.microphone.list}")

# set system mic   
(set | change) system ((mic | mike | mice) | (microphone | like a phone)) [to] {user.community.plugin.microphone_selection.microphone.list}: 
    user.system_command_nb('SwitchAudioSource -t input -s "{user.community.plugin.microphone_selection.microphone.list}"')

# set both talon and systemmic
((set | said) | change) ((mic | mike | mice) | (microphone | like a phone)) [to] {user.community.plugin.microphone_selection.microphone.list}:
    target_mic = user.community.plugin.microphone_selection.microphone.list
    app.notify("Microphone is {target_mic}")
    sound.set_microphone(target_mic)
    user.system_command_nb('SwitchAudioSource -t input -s "{target_mic}"')

[set] ((mic | mike | mice) | (microphone | like a phone)) [(input | and put)] (level | volume)  [to] <user.number_string>:
    user.set_microphone_input_volume(number_string)

[set] ((mic | mike | mice) | (microphone | like a phone)) [(input | and put)] [(level | volume)]  [to] max:
    user.set_microphone_input_volume("100")

release (shock z | Shaky | shocks te | shocks she) [(talon | Tallin | tell in | tellin)] [mic]:
    sound.set_microphone("MacBook Pro Microphone")
    user.system_command_nb('SwitchAudioSource -t input -s "MacBook Pro Microphone"')
    user.talon_quit()