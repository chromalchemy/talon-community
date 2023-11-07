^(microphone | mic | mice) (pick | show | select | list)$: user.microphone_selection_toggle()
^pick (microphone | mic | mice)$: user.microphone_selection_toggle()
^microphone close$ | close mic list: user.microphone_selection_hide()
^(microphone | mic | mice) [(choose | pick)] <number_small>$: user.microphone_select(number_small)
