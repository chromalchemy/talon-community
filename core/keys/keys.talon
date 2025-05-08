#are these done somehere else?
[(go | key)] <user.arrow_keys>: 
    key(arrow_keys)
    # user.move_cursor(arrow_keys)

<user.alt_arrow_keys>: 
    print("alt_arrow_key: {alt_arrow_keys}")
    key(alt_arrow_keys)
    # user.move_cursor(alt_arrow_keys)

<user.letter>: key(letter)

#capitalized letters
(ship | uppercase | all (upper | up)) <user.letters> :
    user.insert_formatted(letters, "ALL_CAPS")

<user.symbol_key>: key(symbol_key)
<user.function_key>: key(function_key)
<user.special_key>: key(special_key)
<user.keypad_key>: key(keypad_key)

<user.modifiers> <user.unmodified_key>: key("{modifiers}-{unmodified_key}")

# for key combos consisting only of modifiers, eg. `press super`.
press <user.modifiers>: key(modifiers)

# for consistency with dictation mode and explicit arrow keys if you need them.
press <user.keys>: key(keys)

(for | fore) (delete | dell) | dell it | deli it | dell that: 
    key(delete)


