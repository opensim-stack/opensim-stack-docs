# Advanced Bot Creation and Spawner API

This page documents the `opensim-metaverse2mcp` spawner-management MCP tools and expected spawner contract.

## Runtime integration

`opensim-metaverse2mcp` now exposes a built-in HTTP spawner client configured by:

- `SPAWNER_HOST` (default: `opensim-ai-spawner`)
- `SPAWNER_PORT` (default: `8993`)
- `SPAWNER_TOKEN` (optional bearer token)

Docker entrypoint maps these into CLI flags:

- `--spawner-host`
- `--spawner-port`
- `--spawner-token`

## Tool surface

- `BotList` -> `GET /api/bot`
- `BotGet` -> `GET /api/bot/{first}/{last}`
- `BotCreate` -> `POST /api/bot/{first}/{last}`
- `BotStart` -> `PATCH /api/bot/{first}/{last}` with `action=start`
- `BotStop` -> `PATCH /api/bot/{first}/{last}` with `action=stop`
- `BotRestart` -> `PATCH /api/bot/{first}/{last}` with `action=restart`
- `BotDelete` -> `DELETE /api/bot/{first}/{last}`

`BotCreate` sends form fields:

- `level` (required)
- `parent` (optional while debugging)
- `email` (optional)
- `model` (optional)

Running-state tools are ownership-limited: a bot may only start/stop/restart itself or its descendants.

If `parent` is omitted at tool call time, the tool defaults parent to the active bot full name (`<BotFirstName> <BotLastName>`).

## Expected response patterns

- Success responses return `DataToolResult.ok=true` with `payloadJson` containing raw spawner JSON.
- Non-2xx responses return `DataToolResult.ok=false` with HTTP status and body excerpt.
- Transport errors (DNS/network/auth wiring issues) return `DataToolResult.ok=false` with exception text.

## Operational guidance

1. **Validate connectivity first**: run `BotList` before issuing create/delete operations.
2. **Use ownership consistently**: always provide exact parent full names for deterministic child graphs.
3. **Reconcile runtime vs desired state**: `BotGet` is the authoritative status view for container state.
4. **Handle auth centrally**: when spawner bearer auth is enabled, set `SPAWNER_TOKEN` in the metaverse container.
5. **Clean up test trees**: delete children before deleting parent bots when running structured hierarchy tests.

## Example prompts

```text
List bots from spawner and show me names, levels, and parents.
```

```text
Create bot Alice Bot2 at level ACTOR with parent Governor Bot and model Ruth.
```

```text
Get bot status for Alice Bot2 and report container states.
```

```text
Delete bot Alice Bot2 and confirm deletion.
```

```text
Restart bot Alice Bot2 so all of its containers are restarted.
```

```text
Stop bot Alice Bot2, then start it again.
```
