(phones [pick] | (choose | pick) (phones | phone | fun)) <user.homophones_canonical>: 
    user.homophones_show(homophones_canonical)

(phones [pick] | (choose | pick) (phones | phone | fun)) that: 
    user.homophones_show_auto()

(phones [pick] | (choose | pick) (phones | phone | fun)) force <user.homophones_canonical>:
    user.homophones_force_show(homophones_canonical)
    
(phones [pick] | (choose | pick) (phones | phone | fun)) force: 
    user.homophones_force_show_selection()

(phones [pick] | (choose | pick) (phones | phone | fun)) hide: 
    user.homophones_hide()

(phones [pick] | (choose | pick) (phones | phone | fun)) word:
    edit.select_word()
    sleep(100ms)
    user.homophones_show_selection()

(phones [pick] | (choose | pick) (phones | phone | fun)) [<user.ordinals>] word left:
    n = ordinals or 1
    user.words_left(n - 1)
    edit.extend_word_left()
    sleep(100ms)
    user.homophones_show_selection()

(phones [pick] | (choose | pick) (phones | phone | fun)) [<user.ordinals>] word right:
    n = ordinals or 1
    user.words_right(n - 1)
    edit.extend_word_right()
    sleep(100ms)
    user.homophones_show_selection()
