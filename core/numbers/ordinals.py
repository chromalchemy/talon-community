from talon import Context, Module, fs
import os

# Load ordinals from the talon-list file
ordinals_list_path = os.path.expanduser('~/.talon/user/community/core/numbers/ordinals.talon-list')

# Create inverse mapping: number -> word
ordinal_words = {}
# Maps ordinal words to their corresponding numbers
ordinal_numbers = {}
ordinal_small = {}

# Fallback tens words for constructing compound ordinals not in the list
tens_words = "zero ten twenty thirty forty fifty sixty seventy eighty ninety".split()

# Parse the talon-list file
if os.path.exists(ordinals_list_path):
    with open(ordinals_list_path, 'r') as f:
        for line in f:
            line = line.strip()
            # Skip comments and empty lines
            if not line or line.startswith('#'):
                continue
                
            # Parse word: number format
            if ':' in line:
                word, number_str = [part.strip() for part in line.split(':', 1)]
                
                try:
                    number = int(number_str)
                    
                    # Add to ordinal_numbers (word -> number)
                    ordinal_numbers[word] = number_str
                    
                    # Add to small ordinals if applicable
                    if number <= 20:
                        ordinal_small[word] = number_str
                    
                    # For the primary forms, add to ordinal_words (number -> word)
                    # We'll prefer the canonical forms like 'first', 'second', etc.
                    # over alternatives like '1st', '2nd'
                    if number not in ordinal_words or not any(c.isdigit() for c in word):
                        ordinal_words[number] = word
                        
                except ValueError:
                    # Skip entries where the number can't be parsed as an integer
                    pass
else:
    # Fallback to a minimal set if the file doesn't exist
    basic_ordinals = {
        0: "zeroed", 1: "first", 2: "second", 3: "third", 4: "fourth",
        5: "fifth", 6: "sixth", 7: "seventh", 8: "eighth", 9: "ninth",
        10: "tenth", 11: "eleventh", 12: "twelfth", 13: "thirteenth",
        14: "fourteenth", 15: "fifteenth", 16: "sixteenth", 17: "seventeenth",
        18: "eighteenth", 19: "nineteenth", 20: "twentieth",
        30: "thirtieth", 40: "fortieth", 50: "fiftieth",
        60: "sixtieth", 70: "seventieth", 80: "eightieth", 90: "ninetieth"
    }
    
    # Initialize dictionaries with the fallback data
    ordinal_words = basic_ordinals.copy()
    
    # Create ordinal_numbers and ordinal_small
    for n, word in basic_ordinals.items():
        ordinal_numbers[word] = str(n)
        if n <= 20:
            ordinal_small[word] = str(n)

# Fill in any missing compound ordinals that weren't in the talon-list
for n in range(1, 100):
    # Skip if we already have this number in ordinal_words
    if n in ordinal_words:
        continue
        
    # Generate compound ordinals (like 'twenty first') for missing numbers
    if 20 < n < 100 and n % 10 != 0:
        tens, units = divmod(n, 10)
        # Make sure we have the component parts
        if tens * 10 in ordinal_words and units in ordinal_words:
            # Create the compound form
            compound_word = f"{tens_words[tens]} {ordinal_words[units]}"
            ordinal_words[n] = compound_word
            ordinal_numbers[compound_word] = str(n)


mod = Module()
ctx = Context()

mod.list("ordinals", "List of ordinals (1-99)")
mod.list("ordinals_small", "List of small ordinals (1-20)")

ctx.lists["user.ordinals"] = ordinal_numbers
ctx.lists["user.ordinals_small"] = ordinal_small


@mod.capture(rule="{user.ordinals}")
def ordinals(m) -> int:
    """Returns a single ordinal as an integer"""
    return int(m.ordinals)


@mod.capture(rule="{user.ordinals_small}")
def ordinals_small(m) -> int:
    """Returns a single small ordinal as an integer"""
    return int(m.ordinals_small)
