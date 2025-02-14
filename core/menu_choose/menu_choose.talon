# pick item from a dropdown
# Assumes you ar in dropdown and choosign first is a no-nav event

[drop] (choose | pick ) [drop] [menu]  <number_small>: 
    user.choose(number_small)

[drop] (choose | pick) [drop] [menu] up <number_small>: 
    user.choose_up(number_small)
