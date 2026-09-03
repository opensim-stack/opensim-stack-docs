# Beginner Event Workflows

This guide shows how to make your assistant react to bot activity in near real-time.

The event tools are useful when you want to:

- notice when the bot disconnects
- watch incoming IM/local chat
- track inventory offers
- observe movement-heavy activity like teleports

## Event channels (simple view)

Use channels to control noise level:

- `general` - login/disconnect/chat/inventory and other normal updates
- `object` - high-volume object update stream
- `teleport` - teleport-specific success/failure events

If you are new to this, start with `general` only.

## Typical beginner flow

1. Create a subscription.
2. Poll it with a short wait timeout.
3. Keep the returned `nextCursor` and reuse it.
4. Unsubscribe when done.

## Example prompts for your AI assistant

Try prompts like these in your MCP client:

- "Create an event subscription for general events and remember it as `main-events`."
- "Poll `main-events` with max 20 results and wait 5000 ms."
- "Keep polling every few seconds and alert me only on disconnect or teleport failures."
- "Create another subscription only for `teleport` events."
- "Create an object subscription within 30m radius around the bot."
- "Create an object watcher for object UUID `<uuid>` only."
- "Filter chat events so only messages from `Governor Bot` show up."
- "Show event stream stats so I can see whether buffers are trimming."
- "Show me event history for the last 120 seconds for teleport failures."
- "Unsubscribe `main-events`."

## Practical tips

!!! tip "Use long-poll for reactive behavior"
    Set a non-zero wait time (for example `3000` to `10000` ms) so polling behaves like a push stream without hammering the server.

!!! tip "Track the cursor"
    Always continue from the last `nextCursor` so you do not re-read the same events.

!!! warning "High-volume channels"
    `object` events can be very busy. Keep them in a separate subscription from your everyday `general` automation.

!!! warning "Trim counters mean you fell behind"
    If trim counters grow, old events were dropped from bounded buffers. Reduce poll interval, reduce channels, or reduce workload per poll.

## Quick filter ideas

- Use `eventTypes` when you only care about specific states such as `network.disconnected`.
- Use `radiusMeters` when watching nearby object activity.
- Use `objectIds` or `objectLocalIds` to track one object.
- Use `chatSources` to scope who can trigger your automations.

## Debug replay

Use `EventStreamHistory` for a short lookback without changing your live subscription cursor.

## What to read next

- **Advanced Guide -> Eventing and Reactive Workflows** (`advanced/events.md`)
- **Beginner Guide -> AI Permissions and Questions** (`beginner/permissions-questions.md`)
