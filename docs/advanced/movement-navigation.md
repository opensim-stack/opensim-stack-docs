# Advanced Movement and Navigation

`opensim-metaverse2mcp` exposes movement tools over MCP HTTP. AI prompts in IM eventually map to these tools.

## Core movement and avatar control tool set

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
- `Stand`
- `Fly`
- `Jump`
- `AnimationStart`
- `AnimationStop`
- `AnimationsList`
- `ActiveAnimations`

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

Tracked attributes can transition between known and unknown and still emit updates:

- online presence
- region (if known)
- local position x/y/z (if known)
- fly state (if known)
- velocity vector (if known)
- heading in degrees (when consecutive known positions allow it)

## Teleport targeting strategy

- Use explicit region names plus coordinates when possible.
- If region name collisions exist, use a region-handle or precise routing command.
- Confirm location with status before issuing object-edit operations.

## Map lookup and region-handle tooling

Use `RegionUuid` when you only have global map coordinates and need the region handle for follow-up operations.

```text
RegionUuid(globalX=99712, globalY=102400)
```

Use `Map` to query map-layer entities directly from a region:

```text
Map(regionHandle="0", itemType="AgentLocations", layerType="Objects")
Map(regionHandle="1099511628032", itemType="LandForSale", layerType="Objects")
Map(regionHandle="1099511628032", itemType="PgEvent", layerType="Objects")
```

Behavior notes:

- `regionHandle="0"` means "use current simulator region handle".
- `itemType` defaults to `AgentLocations`.
- `layerType` defaults to `Objects`.
- JSON rows are type-aware and include subtype-specific fields (for example `avatarCount`, `price`, `description`, `flags`, `category`) in addition to shared map coordinates.

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