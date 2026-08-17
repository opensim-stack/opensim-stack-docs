# Beginner Voice Setup (Piper TTS)

This guide adds text-to-speech voice output for your in-world bot using `opensim-piper`.

## What you get by default

`opensim-piper` starts an HTTP TTS server with two preloaded US English voices:

- `en_US-lessac-medium` (female)
- `en_US-ryan-medium` (male)

If `/voices` is mounted, missing bundled defaults are copied there on startup.

Default endpoint inside the stack network:

```text
http://opensim-piper:8995
```

## Quick run test (standalone)

From the `opensim-piper` repository:

```bash
docker build -t opensim-piper:local .

docker run --rm \
  -e PIPER_HTTP_HOST=0.0.0.0 \
  -e PIPER_HTTP_PORT=8995 \
  -e PIPER_DEFAULT_VOICE=en_US-lessac-medium \
  -p 8995:8995 \
  -v piper-voices:/voices \
  opensim-piper:local
```

In another terminal, synthesize a test WAV file:

```bash
curl -sS -X POST "http://localhost:8995/tts" \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello from OpenSim stack."}' \
  --output hello.wav
```

## Pick a voice

List available voices:

```bash
curl -sS "http://localhost:8995/voices"
```

Set your default voice at startup with environment variable:

```text
PIPER_DEFAULT_VOICE=en_US-ryan-medium
```

## Add another voice

1. Keep `/voices` on a persistent volume (`piper-voices:/voices`).
2. Download a voice pair into that folder:
   - `<voice-name>.onnx`
   - `<voice-name>.onnx.json`
3. Restart `opensim-piper`.
4. Verify with `GET /voices`.

Example download:

```bash
curl -fsSLO "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx"
curl -fsSLO "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json"
```

!!! tip "Keep names exact"
    `PIPER_DEFAULT_VOICE` should match the model file name without `.onnx`.
