#!/usr/bin/python

"""
 modules that allows you to use functions defined elsewhere that interacts with the interpreter
 sys provides access to some variables used or maintained by the interpreter
 re provides full support for Perl-like regular expressions in Python
"""
import sys
import re

"""
The suits variable is a dictionary that stores the key as dwarves and the value as the color that identifies them as strings
"""
suits = {
    'Bashful':'yellow', 'Sneezy':'brown', 'Doc':'orange', 'Grumpy':'red',
    'Dopey':'green', 'Happy':'blue', 'Sleepy':'taupe'
}
pattern = re.compile("(%s)" % sys.argv[1])

"""
The for loop is extracting both a dwarf name or a suit color that matches the user defined pattern on each iteration
"""
for dwarf, color in suits.items():
    if pattern.search(dwarf) or pattern.search(color):
        print("%s's dwarf suit is %s." %
            (pattern.sub(r"_\1_", dwarf), pattern.sub(r"_\1_", color)))
        break
    else:
        print("No dwarves or dwarf suits matched the pattern.")
