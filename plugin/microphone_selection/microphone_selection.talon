^[(talon | talent)] (microphone | mic | mice) (pick | show | select | list)$: user.microphone_selection_toggle()

^pick (microphone | mic | mice)$: user.microphone_selection_toggle()

^(microphone | mic | mice) (close | clothes)$: user.microphone_selection_hide()
^close mic list$: user.microphone_selection_hide()

^(microphone | mic | mice) [(choose | pick)] <number_small>$: user.microphone_select(number_small)

