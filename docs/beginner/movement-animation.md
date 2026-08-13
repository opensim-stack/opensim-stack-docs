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

!!! tip "Use clear targets"
    Give region name plus coordinates when possible. It reduces ambiguity and failed teleports.

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

For tool-level details, see **Advanced Guide -> Movement and Navigation**.