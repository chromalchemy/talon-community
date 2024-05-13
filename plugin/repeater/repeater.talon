# -1 because we are repeating, so the initial command counts as one

<user.ordinals>: core.repeat_command(ordinals - 1)

<number_small> times: core.repeat_command(number_small - 1)

repeat that | again | twice | pop : core.repeat_command(1)

#headset mic not sensitive enough
# noise(pop): core.repeat_command(1)

repeat that <number_small> [times]: core.repeat_command(number_small)

repeat phrase [<number_small> times]:
    core.repeat_partial_phrase(number_small or 1)

# repeat command key    
key(cmd-ctrl-alt-shift-q) : core.repeat_command(1)


