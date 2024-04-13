tag: user.homophones_open
-

[(phones | phone | fun)] (choose | pick) <number_small>:
    result = user.homophones_select(number_small)
    insert(result)
    user.homophones_hide()

[(phones | phone | fun)] (choose | pick) <user.formatters> <number_small>:
    result = user.homophones_select(number_small)
    insert(user.formatted_text(result, formatters))
    user.homophones_hide()
