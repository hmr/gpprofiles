# Part of GPP(General Puropose Profiles)
# mdl style configuration file
#  (*) mdl is a markdown linter implemented by ruby.

all

# Exclude rules: MD013 - Line length
exclude_rule 'MD013'

# Trailing 2 spaces are allowed for line break.
rule 'MD009', :br_spaces => 2

# Both "fence" and "indentation" are allowed for code block.
rule 'MD046', :style => :consistent

# Ordered list number should be ordered.
rule 'MD029', :style => :ordered


