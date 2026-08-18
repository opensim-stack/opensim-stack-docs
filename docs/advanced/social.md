# Advanced Social, Groups, and Session Control

This page covers social MCP workflows: friends/friendship operations, teleport offers/requests, and group membership/session control.

## Chat authorization and routing model

The bot enforces a trust gate before routing chat text to the AI backend.

### Access policy by channel

- `im-<sender-uuid>` (direct IM): allow only handler or C&C group members.
- `local-chat` (spatial/local): allow only handler or C&C group members.
- `group-<group-uuid>`:
  - if `<group-uuid>` is the bot's own C&C group, accept all instructions in that session.
  - otherwise, allow only handler or C&C group members.

Unauthorized speakers receive a polite refusal reply and are not routed to AI execution.

### Wake-word behavior

- Direct IM does not require a wake word.
- Multi-participant chats (group and local) require wake word prefixing:
  - `@<botFirst> <botLast> ...`
  - `@Bot ...` is additionally accepted in the bot's own C&C group chat.

### Command authorization

- Star commands (`*help`, `*status`, `*cancel`, `*configure`, etc.) are handler-only across all chat channels.
- If handler identity is not configured, star commands are refused.

### Session and concurrency notes

- Conversation keys are channel-specific and stable:
  - local: `local-chat`
  - IM: `im-<sender-uuid>`
  - group: `group-<group-uuid>`
- Only one AI request can be active at a time per bot; overlapping requests from another session receive a busy response.

## Friends and teleport tools

- `FriendList`
- `FriendOffersList`
- `FriendOfferSend`
- `FriendOfferRespond`
- `FriendRemove`
- `FriendSetRights`
- `FriendMapLocate`
- `TeleportOfferSend`
- `TeleportRequestSend`
- `TeleportOffersList`
- `TeleportRequestsList`
- `TeleportOfferRespond`

Operational notes:

- `FriendList` includes online status; use `includeDetails=true` to inspect rights from both sides.
- `FriendOfferRespond` uses pending incoming offers tracked by `FriendsManager` (`accept` or `decline`).
- `FriendMapLocate` supports wait mode (`waitForReplySeconds > 0`) to return region-handle and local/global coordinates.
- `TeleportOffersList` and `TeleportRequestsList` expose pending IM-based teleport signals seen during this bot session.
- `TeleportOfferRespond` requires requester UUID plus IM session UUID from a pending offer row.

## Directory and search tools

- `DirectorySearchPeople`
- `DirectorySearchGroups`
- `DirectorySearchPlaces`
- `DirectorySearchLand`

Operational notes:

- All directory tools return `summary`, `pagination`, and `results` payload blocks.
- `pagination.hasMore=true` means you should call the same tool again with `pagination.nextQueryStart`.
- `DirectorySearchPeople`, `DirectorySearchGroups`, and `DirectorySearchPlaces` usually use `queryStart` as page index (`0,1,2,...`).
- `DirectorySearchLand` uses land-sale query offsets more often represented as `0,100,200,...`.
- `DirectorySearchLand` supports `landType` values: `any`, `mainland`, `estate`, `auction` plus optional `maxPrice` and `minArea` filters.

## Avatar profile tools

- `AvatarProfileGet`
- `AvatarPicksList`
- `AvatarClassifiedsList`

Operational notes:

- `AvatarProfileGet` returns UDP profile/interests fields and can optionally include AgentProfile capability payloads when available.
- `AvatarPicksList` returns pick IDs/names first; use `includeDetails=true` to request per-pick details such as sim name, description, and global position.
- `AvatarClassifiedsList` returns classified IDs/names first; `includeDetails=true` enriches with parcel/sim data, pricing, and creation/expiration timestamps.
- Detail lookups are best-effort; missing detail IDs are returned in `missingDetailPickIds` or `missingDetailClassifiedIds`.

## Group discovery and profile tools

- `GroupListCurrent`
- `GroupGetProfile`
- `GroupGetMembers`
- `GroupGetRoles`
- `GroupGetRoleMembers`
- `GroupGetTitles`

Use `includeDetails=false` for fast summaries and `includeDetails=true` when you need full payloads.

## Group chat/session tools

- `GroupChatJoin`
- `GroupChatLeave`
- `GroupChatSend`
- `GroupChatSessionsList`
- `GroupChatAcceptInvite`

Operational notes:

- `GroupChatSend` requires an active tracked session; join first if needed.
- `GroupChatJoin` supports `waitForJoinSeconds` (`0` = fire-and-forget, `>0` = wait for `GroupChatJoined`).
- `GroupChatSessionsList` with `includeDetails=true` surfaces per-member moderation/voice flags.

## Role/title action tools

- `GroupSetActive`
- `GroupSetActiveTitle`
- `GroupRoleCreate`
- `GroupRoleUpdate`
- `GroupRoleDelete`
- `GroupRoleAddMember`
- `GroupRoleRemoveMember`

Verification notes:

- `GroupRoleAddMember` and `GroupRoleRemoveMember` support `verifyAfterSubmit` and `verifyWaitSeconds`.
- When verification is enabled, tools classify outcomes as confirmed vs submitted-but-unverified.

### Structured role payload (Option B)

`GroupRoleCreate` and `GroupRoleUpdate` accept this object schema:

```json
{
  "name": "Builder",
  "title": "Builder",
  "description": "Can edit and maintain builds",
  "powers": "ObjectManipulate,ObjectSetForSale"
}
```

`powers` supports either:

- comma/pipe-separated `GroupPowers` enum names, or
- numeric bitmask string.

## Group invite and ban tools

- `GroupInviteUser`
- `GroupBanListGet`
- `GroupBanSet`

### Structured invite payload

```json
{
  "targetAgentId": "99999999-8888-7777-6666-555555555555",
  "roleIdsCsv": null,
  "useEveryoneRoleIfEmpty": true
}
```

### Structured ban payload

```json
{
  "action": "ban",
  "agentIdsCsv": "99999999-8888-7777-6666-555555555555"
}
```

Ban notes:

- `GroupBanSet` supports `verifyAfterSubmit` and `verifyWaitSeconds`.
- Verification uses read-back from `GroupBanListGet`-equivalent state and returns classified outcomes.

## Notice tools

- `GroupNoticesList`
- `GroupNoticeSend`

### Structured notice payload

```json
{
  "subject": "Weekly restart",
  "message": "Region restart in 10 minutes.",
  "attachmentItemId": null,
  "attachmentOwnerId": null
}
```

If attachment fields are used, both IDs are required and must be UUIDs.

## Group create/update tools (structured payload)

- `GroupCreate`
- `GroupUpdate`

### Structured group payload (Option B)

```json
{
  "name": "OpenSim Builders",
  "charter": "Collaborative build group",
  "insigniaId": null,
  "membershipFee": 0,
  "openEnrollment": true,
  "showInList": true,
  "allowPublish": false,
  "maturePublish": false
}
```

## Suggested execution order

1. Query current state (`GroupListCurrent`, `GroupGetRoles`, `GroupGetTitles`).
2. Apply one change (`GroupRoleUpdate`, `GroupSetActiveTitle`, or `GroupNoticeSend`).
3. Re-read state to verify (`GroupGetRoles`/`GroupGetTitles`/`GroupNoticesList`/`GroupBanListGet`).
4. For chat automation, verify active sessions with `GroupChatSessionsList` before sending.

## Prompt examples

```text
List my friends with detailed rights and online status.
```

```text
Show pending friendship offers and accept one from 99999999-8888-7777-6666-555555555555.
```

```text
Send a teleport offer to 99999999-8888-7777-6666-555555555555 with message "Join me at the sandbox stage".
```

```text
Show pending teleport offers and decline the newest one.
```

```text
Search people for "cube" starting at page 0.
```

```text
Search groups for "builders" and continue with the returned nextQueryStart if hasMore is true.
```

```text
Search places for "sandbox" from queryStart 0.
```

```text
Search land listings of type mainland with maxPrice 5000 and minArea 512 starting at 0.
```

```text
Get avatar profile and interests for 99999999-8888-7777-6666-555555555555 with capability details enabled.
```

```text
List picks for 99999999-8888-7777-6666-555555555555 with details.
```

```text
List classifieds for 99999999-8888-7777-6666-555555555555 with details.
```

```text
List my groups with details.
```

```text
Join group chat for 11111111-2222-3333-4444-555555555555 and wait up to 12 seconds.
```

```text
Create role Moderators in group 11111111-2222-3333-4444-555555555555 with powers Invite and ChangeOptions.
```

```text
Send a notice to group 11111111-2222-3333-4444-555555555555 saying deployment starts in 5 minutes.
```

```text
Invite avatar 99999999-8888-7777-6666-555555555555 to group 11111111-2222-3333-4444-555555555555 using Everyone role fallback.
```

```text
Ban avatar 99999999-8888-7777-6666-555555555555 from group 11111111-2222-3333-4444-555555555555 and verify for 15 seconds.
```
