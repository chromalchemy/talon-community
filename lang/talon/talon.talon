code.language: talon
-
tag(): user.code_operators_math
tag(): user.code_operators_assignment
tag(): user.code_comment_line
tag(): user.code_functions_common

# uncomment user.talon_populate_lists tag to activate talon-specific lists of actions, scopes, modes etcetera.
# Do not enable this tag with dragon, as it will be unusable.
# with conformer, the latency increase may also be unacceptable depending on your cpu
# see https://github.com/talonhub/community/issues/600
tag(): user.talon_populate_lists

#defintion blocks for the context
setting block: insert("settings():\n\t")

########andreas stuff

# Context requirements
# require win:                "os: windows\n"
# require mac:                "os: mac\n"
# require linux:              "os: linux\n"
# require title:              "title: "
# require app:                "app: "
# require tag:                "tag: "

# # Generic
# make tag:                   "tag(): "
# make true:                  "true"
# make false:                 "false"
# snip command:               user.code_insert_snippet("voiceCommandDeclaration")

# ----- Function call -----
# call {user.code_function}:  user.code_call_function(code_function)