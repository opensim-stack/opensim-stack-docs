# Advanced Eventing and Reactive Workflows

This page covers the MCP runtime event stream tools for automation loops, watchers, and controller bots.

## Why use the event tools

Polling action tools directly is expensive and race-prone. The event stream gives you:

- a normalized event envelope across runtime sources
- cursor-based continuation
- bounded buffers with explicit trim diagnostics
- channel separation for high-volume signals

## Tools

- `EventStreamSubscribe(channels, eventTypes, radiusMeters, objectIds, objectLocalIds, chatSources)`
- `EventStreamPoll(subscriptionId, cursor, channels, eventTypes, radiusMeters, objectIds, objectLocalIds, chatSources, maxResults, waitMs)`
- `EventStreamHistory(lastSeconds, channels, eventTypes, radiusMeters, objectIds, objectLocalIds, chatSources, maxResults)`
- `EventStreamUnsubscribe(subscriptionId)`
- `EventStreamStats()`

## Runtime model

### Channels

- `general`: login/disconnect/chat/inventory-offer/script-dialog and similar lifecycle events
- `object`: object update stream (high-volume)
- `teleport`: teleport success/failure stream

`all` is accepted when creating or overriding channels.

### Cursor semantics

- Cursors are monotonic event IDs.
- `EventStreamPoll` returns `nextCursor`; use it as the next call's `cursor`.
- Subscriptions persist their own cursor; omit `cursor` to use stored state.

### Long-poll (hybrid default)

Set `waitMs > 0` to block briefly for new events while retaining cursor replay behavior.

Recommended baseline:

- `maxResults`: `50` to `200`
- `waitMs`: `3000` to `10000`

### Backpressure and trimming

Buffers are bounded per channel. When full, the oldest events are trimmed.

Use these fields to detect and handle loss:

- `CursorTrimmed`
- `TrimmedTotal`
- `TrimmedGeneral`
- `TrimmedObject`
- `TrimmedTeleport`

Recovery pattern after trim:

1. Record that loss occurred (metrics/log).
2. Continue from returned `nextCursor`.
3. Optionally trigger a state reconciliation pass (inventory/object snapshot tools) before resuming normal loops.

## Event type filtering

`eventTypes` accepts a delimited list (comma/space/pipe). Keep filters narrow for high-volume workflows.

Common patterns:

- only failures: `teleport.failed,network.disconnected`
- chat-focused: `chat.im.received,chat.local.received`
- lifecycle: `login.success,login.failed,login.connected,network.disconnected`
- scripted dialogs: `script.dialog.received`

## Script dialog workflow

When a scripted object opens a dialog for the bot, runtime emits `script.dialog.received` on `general`.
The event attributes include a `pendingDialogHandle` plus object/owner metadata and button labels.

Typical handling loop:

1. Poll `general` (or filtered `eventTypes="script.dialog.received"`).
2. Read `pendingDialogHandle` from the event.
3. Call `ListScriptDialogs(pendingDialogHandle="<handle>")` to inspect message/buttons.
4. Reply with `ScriptDialogChoice(pendingDialogHandle="<handle>", buttonIndex=<n>)`.
5. Use `buttonIndex=-1` to cancel/remove a pending dialog without clicking any button.

## Attribute filters

- `radiusMeters`: retain only events near current bot position (events without coordinates are excluded)
- `objectIds`: UUID filter for object-related events
- `objectLocalIds`: local ID filter for object-related events
- `chatSources`: source name/UUID/source-type matching for chat events

For production, keep each consumer focused on one workload class (for example object watcher vs chat watcher).

## History replay window

Use `EventStreamHistory` for short retained replay during debugging:

- `lastSeconds` is clamped to a bounded short window
- returns latest matching events in the requested window
- does not mutate subscription cursor state

## Recommended topologies

### 1) Operator monitor

- Subscription A: `general`
- Filters: failures + disconnect + inventory decisions
- Poll: every `5s` long-poll

### 2) Build/scene automation

- Subscription A: `object`
- Subscription B: `teleport`
- Keep object and teleport split to avoid starvation.

### 3) Conversation supervisor

- Subscription A: `general`
- Filters: chat + disconnect
- On disconnect, pause workflows and wait for reconnect events.

## Example MCP call sequence

```text
1) EventStreamSubscribe(channels="general", eventTypes="network.disconnected,teleport.failed", chatSources="Governor Bot")
2) EventStreamPoll(subscriptionId="<id>", maxResults=100, waitMs=5000)
3) EventStreamPoll(subscriptionId="<id>", cursor="<nextCursor>", maxResults=100, waitMs=5000)
4) EventStreamHistory(lastSeconds=120, channels="teleport", eventTypes="teleport.failed", maxResults=50)
5) EventStreamStats()
6) EventStreamUnsubscribe(subscriptionId="<id>")
```

## Operational notes

- Prefer multiple narrow subscriptions over one broad `all` subscription in production.
- Run object-intensive consumers separately from human-facing chat consumers.
- Periodically sample `EventStreamStats` and alert on increasing trim counters.
- Keep handler-side processing idempotent; duplicate-safe consumers are easier to recover.

## Related pages

- **Beginner Guide -> Event Workflows** (`beginner/events.md`)
- **Advanced Guide -> Hardening** (`advanced/hardening.md`)
- **Reference -> Components** (`reference/components.md`)
