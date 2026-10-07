# Advanced Movement and Animation

`opensim-metaverse2mcp` exposes movement and animation tools over MCP HTTP. AI prompts in IM map to these tools.

## Core movement, sit, and animation tool set

- `MoveBy`
- `WalkTo`
- `FlyTo`
- `TeleportTo`
- `TeleportToRegionHandle`
- `RegionUuid`
- `Map`
- `StopMovement`
- `StartMovement`
- `LookAt`
- `SetCameraHeading`
- `GetCameraState`
- `Follow`
- `MonitorAgent`
- `StopFollow`
- `Sit`
- `SitOnPrim`
- `SitOnPrimByName`
- `SitOnNearestSittablePrim`
- `Stand`
- `Fly`
- `Jump`
- `AnimationStart`
- `AnimationStop`
- `AnimationsList`
- `ActiveAnimations`

## Sit semantics and chair workflows

- `Sit` performs a ground sit only.
- `SitOnPrim(localId=...)` performs object sit handshake (`RequestSit` -> wait `AvatarSitResponse` -> `Sit`).
- `SitOnPrimByName(name=...)` resolves nearest name match in current simulator cache, then uses object sit handshake.
- `SitOnNearestSittablePrim(...)` searches around the bot, prefers explicit sit targets, and sits on the nearest candidate.

Examples:

```text
SitOnPrim(localId=503191167)
SitOnPrimByName(name="deck chair", exactMatch=false, caseSensitive=false)
SitOnNearestSittablePrim(radiusMeters=12, requireExplicitSitTarget=false)
SitOnNearestSittablePrim(radiusMeters=20, requireExplicitSitTarget=true)
```

Operational notes:

- Object sit can fail if the bot is too far away from the target.
- If no `AvatarSitResponse` arrives, move closer and retry.
- Some furniture is sit-enabled by script/poseball rather than `ClickAction=Sit`; name-based or nearest search is often more reliable than strict explicit sit filtering.

## Animation control

Use `AnimationsList` to discover built-in animation names (e.g. `DANCE1`, `WAVE`, `CLAP`, `SIT`), then start/stop them by name or raw UUID:

```text
AnimationsList()
AnimationStart(animation="DANCE1")
ActiveAnimations()
AnimationStop(animation="DANCE1")
```

## Reliable navigation pattern

For long distances, prefer waypoint-style prompts:

```text
Walk to 140,130,25 first, then fly to 200,200,60, then land.
```

This aligns with stepped autopilot behavior used by movement tools.

## Agent monitoring pattern

Use `MonitorAgent` when you need continuous presence tracking for another avatar UUID.
The tool runs as a background `BotTaskHandle` and emits change events on runtime channel `agentMonitor` once per second at most.

Current behavior is intentionally current-region scoped: if the target is not in the bot's current simulator, `region`, `position`, `velocity`, and `isFlying` are reported as unknown (`null`).
External fallback probing is disabled by default; enable `AGENT_MONITOR_EXTERNAL_FALLBACK=true` only if you want occasional off-region online checks.

## Teleport targeting strategy

- Use explicit region names plus coordinates when possible.
- If region name collisions exist, use a region-handle or precise routing command.
- Confirm location with status before issuing object-edit operations.

## Operational checks

Health endpoint for bot runtime:

```bash
curl -s http://127.0.0.1:8999/healthz
```

If your mapped host port is not `8999`, adjust the URL.

## Failure recovery

- If movement hangs, send:

```text
*cancel
Stop movement.
```

- If login session is stale, restart only the metaverse sidecar:

```bash
docker compose restart opensim-metaverse2mcp
```

!!! tip "Handler-gated control"
    If handler restrictions are enabled, only the configured handler avatar can issue bot control commands.

For tool-level outfit, wearable, and attachment operations, see **Advanced Guide -> Appearance and Wearables**.
