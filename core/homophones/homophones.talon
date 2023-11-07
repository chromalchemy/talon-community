(phones  | phone choice) <user.homophones_canonical>: user.homophones_show(homophones_canonical)
(phones  | phone choice) that: user.homophones_show_auto()
(phones  | phone choice) force <user.homophones_canonical>:
    user.homophones_force_show(homophones_canonical)
(phones  | phone choice) force: user.homophones_force_show_selection()
(phones  | phone choice) hide: user.homophones_hide()
(phones  | phone choice) word:
    edit.select_word()
    sleep(100ms)
    user.homophones_show_selection()
(phones  | phone choice) [<user.ordinals>] word left:
    n = ordinals or 1
    user.words_left(n - 1)
    edit.extend_word_left()
    sleep(100ms)
    user.homophones_show_selection()
(phones  | phone choice) [<user.ordinals>] word right:
    n = ordinals or 1
    user.words_right(n - 1)
    edit.extend_word_right()
    sleep(100ms)
    user.homophones_show_selection()
