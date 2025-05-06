mode: command
mode: dictation
-

^(dictate | dictation | dict | dick | talk) mode$:
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("dictation")
    user.code_clear_language_mode()
    user.gdb_disable()

^(dictation | dictate):
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("dictation")
    user.code_clear_language_mode()
    user.gdb_disable()

^(dictation | dictate) <user.raw_prose>:
    mode.disable("sleep")
    mode.disable("command")
    mode.enable("dictation")
    user.code_clear_language_mode()
    user.gdb_disable()
    user.dictation_insert(raw_prose)

^((command | commander | com | calm | coms | action | act) mode | commander)$:
    mode.disable("sleep")
    mode.disable("dictation")
    mode.enable("command")

^((mixed | mix) (mode | com | coms) | mixier)$:
  mode.disable("sleep")
  mode.enable("dictation")
  mode.enable("command")

# not working
# change engine:
#     user.settings("speech.engine", "wav2letter")
