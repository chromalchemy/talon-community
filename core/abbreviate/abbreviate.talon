-
(abbreviate | abreviate | (brief | breathe) ) {user.abbreviation}: "{abbreviation}"

(go | open) [(talon  | talin | tellin)] [voice] abbreviations: 
    key(cmd-p)
    sleep(100ms)
    insert("community/settings/abbreviations.csv")
    sleep(200ms)
    key(enter)



