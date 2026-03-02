mode: command
mode: dictation
-

^(dictate | dictation | dict | dick | talk) mode$:
    user.dictation_mode()

^(dictation | dictate):
    user.dictation_mode()

^(dictation | dictate) <user.raw_prose>:
    user.dictation_mode()
    user.dictation_insert(raw_prose)

^((command | commander | com | calm | coms | action | act) mode | commander)$:
    user.command_mode()

^((mixed | mix) (mode | com | coms) | mixier)$:
  mode.disable("sleep")
  mode.enable("dictation")
  mode.enable("command")

# not working
# change engine:
#     user.settings("speech.engine", "wav2letter")
