# Component Reference

## `opensim-ai-docker`

Main composition repository that orchestrates all services.

Primary files:

- `docker-compose.yml` (source mode)
- `docker-compose.release.yml` (release mode)
- `.env.example`
- `run.sh` / `run-release.sh`

## `opensim` + `opensim-init`

- `opensim-init` generates first-run config from environment variables.
- `opensim` runs the OpenSimulator runtime.
- REST console endpoints are expected on the simulator HTTP endpoint.

## `opensim-console2mcp`

- Bridges OpenSimulator REST console to MCP.
- Typical in-stack endpoint: `http://opensim-console2mcp:8997/mcp`.
- Key inputs: `OPENSIM_CONSOLE_URL`, `OPENSIM_CONSOLE_USER`, `OPENSIM_CONSOLE_PASS`.

## `opensim-metaverse2mcp`

- Logs bot avatar into the grid.
- Exposes movement/building/inventory/environment tools over MCP HTTP.
- Handles IM-driven star commands for sessions, provider auth, and runtime configuration.

## `opensim-blender`

- MCP bridge for Blender authoring workflows in the same stack.
- Typical in-stack endpoint: `http://opensim-blender:8996/mcp`.
- Uses the `blender-mcp` project to expose Blender operations to MCP-compatible agents.
- Upstream project: <https://github.com/ahujasid/blender-mcp>

## `opensim-piper`

- Provides text-to-speech (TTS) over HTTP for voice-enabled bot workflows.
- Typical in-stack endpoint: `http://opensim-piper:8995`.
- Ships with preloaded US English voices and supports additional model drops via `/voices` volume.

## `opensim-opencode-init` and `opensim-opencode`

- Init service writes stack `opencode.json` with MCP wiring.
- Opencode service runs server mode and executes tool-using AI sessions.

## Data and volume model

Common persistent volumes include:

- `opensim-mariadb`
- `opensim-workspace`
- `opensim-config`
- `opensim-assetcache`
- `opensim-maptiles`
- `opencode-data`
- `opencode-state`
- `opencode-cache`
- `opencode-config`

## Related repositories

- `opensim-console2mcp`: <https://github.com/opensim-stack/opensim-console2mcp>
- `opensim-metaverse2mcp`: <https://github.com/opensim-stack/opensim-metaverse2mcp>
- `opensim-opencode`: <https://github.com/opensim-stack/opensim-opencode>
- `opensim-blender`: <https://github.com/opensim-stack/opensim-blender>
- `opensim-piper`: <https://github.com/opensim-stack/opensim-piper>
- `blender-mcp`: <https://github.com/ahujasid/blender-mcp>
- `libremetaverse`: <https://github.com/opensim-stack/libremetaverse>
