# Piper TTS Setup on Arch Linux (Speech-Dispatcher)

This guide describes how to set up Piper as the default high-quality local TTS engine on Arch Linux using `speech-dispatcher`.

## 1. Prerequisites
Install the required packages from the AUR or official repos:
- `piper-tts-bin` (AUR) or `piper-tts`
- `speech-dispatcher`
- `piper-voices-en-us-ryan-high` (or your preferred voice)

## 2. Configuration Files

### Speech Dispatcher Main Config
File: `~/.config/speech-dispatcher/speechd.conf`
Ensure these lines are present and not commented out:
```conf
AddModule "piper" "sd_generic" "piper.conf"
DefaultModule piper
```

### Piper Module Config
File: `~/.config/speech-dispatcher/modules/piper.conf`
Use the `piper-dispatcher` wrapper script for the most reliable performance:
```conf
GenericExecuteSynth "env DATA=\"\$DATA\" VOICE=\"\$VOICE\" /usr/bin/piper-dispatcher"
GenericLanguage "en"
GenericCmdDependency "piper-tts"
GenericDefaultCharset "utf-8"

DefaultVoice "en/en_US/ryan/high/en_US-ryan-high"
AddVoice "en" "MALE1" "en/en_US/ryan/high/en_US-ryan-high"
```

## 3. The Dispatcher Script
The `piper-dispatcher` script (`/usr/bin/piper-dispatcher`) handles the environment variables and pipes the output to the correct audio sink (PipeWire or ALSA).

## 4. Troubleshooting

### Hangs when using `spd-say`
If `spd-say` hangs, it is often due to an audio sink conflict.
1. **Check Audio Sink:** Verify if `pw-play` (PipeWire) or `aplay` (ALSA) works directly.
2. **Test Manually:**
   ```bash
   export DATA="Testing piper"
   export VOICE="en/en_US/ryan/high/en_US-ryan-high"
   /usr/bin/piper-dispatcher
   ```
3. **Restart Service:**
   ```bash
   systemctl --user restart speech-dispatcher
   ```
4. **Debug Logs:**
   Check `/run/user/1000/speech-dispatcher/log/piper.log` for specific "Broken pipe" or "Module Error" messages.

### No Sound
Ensure the voice path in `piper.conf` matches the actual location in `/usr/share/piper-voices/`.
