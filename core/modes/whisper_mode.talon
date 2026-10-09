mode: user.whisper
-
settings():
    # longer pause allowed before Talon ends the utterance (global default is 0.4 in settings.talon)
    speech.timeout = 1.5
    # Conformer D2 (2026-05-05) + Whisper
    speech.engine = "wav2letter"
    speech._engine_id = "10b77ed32e62ae9cc2ab10f7e806fa8a3e84e4bd7b394d702ff323ce6c4d98dd"
