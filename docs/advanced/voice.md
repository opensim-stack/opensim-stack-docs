# Advanced Voice Configuration (Piper TTS)

`opensim-piper` provides HTTP text-to-speech for bot and automation workflows.

## Service defaults and wiring

Recommended internal stack endpoint:

```text
http://opensim-piper:8995
```

Default environment values:

- `PIPER_HTTP_HOST=0.0.0.0`
- `PIPER_HTTP_PORT=8995`
- `PIPER_VOICE_DIR=/voices`
- `PIPER_DEFAULT_VOICE=en_US-lessac-medium`
- `PIPER_TIMEOUT_SECONDS=60`

Preloaded voices in image:

- `en_US-lessac-medium` (female)
- `en_US-ryan-medium` (male)

When `/voices` is mounted, missing bundled defaults are copied into the mounted directory on startup.

## HTTP API

- `GET /health` status + default voice + available voices
- `GET /voices` voice inventory
- `POST /tts` and `POST /v1/tts` synthesis endpoint (`audio/wav` response)

Request body fields:

- `text` (required)
- `voice` (optional; defaults to `PIPER_DEFAULT_VOICE`)
- `speaker`, `length_scale`, `noise_scale`, `noise_w`, `sentence_silence` (optional Piper controls)

Example request:

```bash
curl -sS -X POST "http://opensim-piper:8995/tts" \
  -H "Content-Type: application/json" \
  -d '{
    "text":"Session started.",
    "voice":"en_US-ryan-medium",
    "length_scale":1.0,
    "noise_scale":0.667
  }' \
  --output session-start.wav
```

## Add and manage voices

Use a persistent voice volume so added models survive rebuilds/restarts.

### Add a voice model

Download both artifacts into `PIPER_VOICE_DIR`:

- `<voice-name>.onnx`
- `<voice-name>.onnx.json`

Example:

```bash
curl -fsSLO "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx"
curl -fsSLO "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json"
```

### Promote new default voice

Set environment value and restart service:

```text
PIPER_DEFAULT_VOICE=en_GB-alan-medium
```

### Health check pattern

```bash
curl -sS "http://opensim-piper:8995/health"
```

## Compose snippet pattern

```yaml
services:
  opensim-piper:
    image: bithatch/opensim-piper:latest
    environment:
      PIPER_HTTP_HOST: 0.0.0.0
      PIPER_HTTP_PORT: 8995
      PIPER_DEFAULT_VOICE: en_US-lessac-medium
      PIPER_TIMEOUT_SECONDS: 60
    volumes:
      - piper-voices:/voices
    ports:
      - "8995:8995"

volumes:
  piper-voices:
```
