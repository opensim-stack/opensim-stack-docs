# Beginner Bot Creation and Ownership

This page shows how to spawn and manage bots with the MCP tools that call `opensim-spawner`.

## What you can do

- List known bots.
- Create a bot at a specific level.
- Restart an existing bot's containers.
- Check one bot status (including `parent` and `children`).
- Delete a bot and its containers.

## MCP tools

- `BotList`
- `BotGet`
- `BotCreate`
- `BotStart`
- `BotStop`
- `BotRestart`
- `BotDelete`

## Starter prompts

```text
List bots managed by the spawner.
```

```text
Create bot Alice Bot2 at level ACTOR.
```

```text
Create bot Alice Bot2 at level ACTOR with parent Governor Bot.
```

```text
Get bot status for Alice Bot2.
```

```text
Delete bot Alice Bot2.
```

```text
Restart bot Alice Bot2.
```

```text
Stop bot Alice Bot2.
```

```text
Start bot Alice Bot2.
```

## Ownership notes

- Parent format is full avatar name: `"<first> <last>"`.
- Spawner currently allows blank parent while debugging, but production policy can require it.
- Parent bots may only create child bots at a higher level number.

## Safe workflow

1. Run `BotList` before creating so you can avoid duplicate names.
2. Run `BotGet` right after create to confirm both bot containers are running.
3. Keep parent names exact (`First Last`) so ownership and child lookup are correct.
4. Use `BotDelete` to clean up inactive test bots.
