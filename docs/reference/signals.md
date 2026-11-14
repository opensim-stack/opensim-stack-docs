# Signals API (Bot-to-Object Discovery)

Signals is a lightweight discovery pattern for object-side capabilities in-world.

It lets `opensim-metaverse2mcp` learn which scripted objects expose bot-friendly APIs, then retrieve a schema/description for those APIs.

## What Signals is for

Use Signals when you want a bot to discover interactive objects without hardcoding object UUIDs or manual setup.

Typical examples:

- Kiosks exposing queryable product data.
- Teleport boards exposing destination catalogs.
- NPC controllers exposing public command schemas.

## Discovery model

Signals discovery is based on periodic object chat broadcasts.

- Objects broadcast an IAH payload (`I am here`) as:
  - `<protocolVersion>|<uri>`
- `opensim-metaverse2mcp` listens for these object messages and keeps a short-lived cache.
- Cache entries include sender UUID, owner UUID, object metadata, location, URI, protocol version, and last-heard time.
- Entries expire after 5 minutes if not refreshed.

## New MCP tools

## `signals_nearby`

Returns cached signal-capable objects in the current simulator.

Parameters:

- `agentUuid` (optional): owner UUID filter.
- `radius` (optional): distance filter in meters from the bot.

Use this first to discover targets and obtain `senderId` values.

## `signals_description`

Fetches the API/schema description for one discovered object.

Parameters:

- `objectSenderId` (required): sender UUID returned by `signals_nearby`.

Supported URI transports from cached discovery URI:

- `http://.../SIGNALS.json` or `http://.../SIGNALS.md`
- `https://.../SIGNALS.json` or `https://.../SIGNALS.md`
- `chat://<channel>/SIGNALS.json` or `chat://<channel>/SIGNALS.md`

For `chat://`, the bridge sends the requested resource name over the channel and waits briefly for a response from the same object sender UUID.

## Suggested workflow

1. Call `signals_nearby`.
2. Choose an object from the returned list.
3. Call `signals_description(objectSenderId)`.
4. Use returned schema/description with existing chat or HTTP tools.

## Notes and limits

- Discovery is cache-based and eventually consistent.
- If no objects are returned, wait for another object broadcast cycle and try again.
- `signals_description` requires a cached discovery entry for the sender.
