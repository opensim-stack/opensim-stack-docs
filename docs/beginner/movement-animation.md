# Beginner Movement and Animation

These examples are natural-language prompts you can send to the bot in IM.

## Basic movement prompts

```text
Walk to me.
```

```text
Move 5 meters forward.
```

```text
Fly to me and land.
```

```text
Stop moving.
```

## Teleport prompts

```text
Teleport to region Welcome Island at 128,128,25.
```

```text
Teleport back to my current region.
```

## Region and map lookup prompts

```text
Find the region handle at global map coordinates 99712, 102400.
```

```text
Show agent location map markers for my current region.
```

```text
Show land-for-sale map entries for region handle 1099511628032.
```

!!! tip "Use clear targets"
    Give region name plus coordinates when possible. It reduces ambiguity and failed teleports.

!!! tip "When to use map lookup"
    If you only have global map coordinates, resolve the region handle first, then query map data for that handle.

## Animation prompts

```text
Wave at me.
```

```text
Play the dance animation.
```

```text
Start clapping.
```

```text
Stop all animations.
```

```text
What animations are you playing?
```

!!! tip "Use built-in animation names"
    Names like `wave`, `dance`, `clap`, `bow`, `laugh`, and `sit` resolve to the viewer's built-in animations. You can also pass an animation UUID directly.

## Animation permission prompts (object requests)

Some scripted chairs/objects ask permission before they can animate the bot avatar.
When this happens, the runtime emits `script.permission.animation.requested` on channel `general`.

Try prompts like:

```text
Show pending animation permission requests.
```

```text
Approve the latest animation permission request.
```

```text
Reject animation permission request handle <handle>.
```

Behind the scenes these map to:

- `ListScriptAnimationPermissionRequests`
- `ScriptAnimationPermissionRespond`

## Sitting on chairs and objects

```text
Sit on prim 503191167.
```

```text
Sit on the nearest chair.
```

```text
Find the nearest explicit sit target within 15 meters and sit.
```

!!! note "Ground sit vs object sit"
    `sit` by itself does a ground sit. For furniture/chairs, use object-targeted sit requests (by local ID, by name, or nearest sittable prim).

!!! tip "If sit fails"
    Move the bot closer to the chair and retry. Some objects require proximity before they return an `AvatarSitResponse`.

## Follow-and-demonstrate workflow

1. Ask the bot to come near you.
2. Ask it to fly to a point.
3. Ask it to stop.
4. Ask it to return.

Example sequence:

```text
Walk to me.
Fly to 140,130,45.
Stop movement.
Walk back to 128,128,25.
```

## Troubleshooting movement and animation

- If the bot does not respond, confirm you are messaging the correct avatar.
- If commands lag, check container health and logs.
- If teleport fails, verify the destination region exists and is online.
- If an animation does not play, check that the name is a known built-in animation or provide a valid animation UUID.

For avatar clothing and attachment prompts, see **Beginner Guide -> Appearance and Wearables**.

For tool-level details, see **Advanced Guide -> Movement and Animation**.