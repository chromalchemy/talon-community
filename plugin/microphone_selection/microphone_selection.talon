^[(talon | talent)] (microphone | mic | mice) (pick | show | select | list)$: 
    user.microphone_selection_toggle()

^pick (microphone | mic | mice)$: 
    user.microphone_selection_toggle()

^(microphone | mic | mice) (close | clothes)$: 
    user.microphone_selection_hide()

^close mic list$: 
    user.microphone_selection_hide()

^(microphone | mic | mice) [(choose | pick)] <number_small>$: 
    user.microphone_select(number_small)

# set talon mic 
(set | change) talon (mic | mike | microphone) [to] {user.community.plugin.microphone_selection.microphone.list}: 
    print("manually setting microphone to {user.community.plugin.microphone_selection.microphone.list}")
    sound.set_microphone("{user.community.plugin.microphone_selection.microphone.list}")

# set system mic   
(set | change) system (mic | mike | microphone) [to] {user.community.plugin.microphone_selection.microphone.list}: 
    user.system_command_nb('SwitchAudioSource -t input -s "{user.community.plugin.microphone_selection.microphone.list}"')

# set both talon and systemmic
((set | said) | change) (mic | mike | microphone) [to] {user.community.plugin.microphone_selection.microphone.list}:
    target_mic = user.community.plugin.microphone_selection.microphone.list
    app.notify("Microphone is {target_mic}")
    sound.set_microphone(target_mic)
    user.system_command_nb('SwitchAudioSource -t input -s "{target_mic}"')

[set] (mic | mike | microphone) [(input | and put)] (level | volume)  [to] <user.number_string>:
    user.set_microphone_input_volume(number_string)

[set] (mic | mike | microphone) [(input | and put)] [(level | volume)]  [to] max:
    user.set_microphone_input_volume("100")