# Advanced Social, Groups, and Session Control

This page covers group-focused MCP workflows: membership visibility, group chat/session control, role/title management, and group notices.

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
