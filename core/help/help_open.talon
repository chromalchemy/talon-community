tag: user.help_open
-
help next$: user.help_next()
help (previous | prev | last)$: user.help_previous()
help <number>$: user.help_select_index(number - 1)
help (return | back)$: user.help_return()
help refresh$: user.help_refresh()
help close$: user.help_hide()
