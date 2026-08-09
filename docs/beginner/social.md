# Beginner Social and Groups

This page helps you use group features in plain language with safe, incremental prompts.

## What you can do now

- List the groups your bot is currently in.
- Join and leave group chat sessions.
- Send group chat messages after joining a session.
- View group members, roles, titles, and notices.
- Send a group notice (with optional attachment IDs).
- Set active group and active group title.
- Invite avatars to a group.
- View and manage group bans (if your role has permission).

## Starter prompts

```text
Show my current groups.
```

```text
Join group chat for group UUID 11111111-2222-3333-4444-555555555555.
```

```text
Send to group chat 11111111-2222-3333-4444-555555555555: Hello everyone.
```

```text
List group members for 11111111-2222-3333-4444-555555555555.
```

```text
List group notices for 11111111-2222-3333-4444-555555555555.
```

```text
Send a group notice to 11111111-2222-3333-4444-555555555555 with subject Weekly Meeting and message Meeting starts in 10 minutes.
```

```text
Invite avatar 99999999-8888-7777-6666-555555555555 to group 11111111-2222-3333-4444-555555555555 using the Everyone role.
```

```text
Show banned agents for group 11111111-2222-3333-4444-555555555555.
```

```text
Ban avatar 99999999-8888-7777-6666-555555555555 from group 11111111-2222-3333-4444-555555555555 and verify the result.
```

## Role and title examples

```text
Set my active group to 11111111-2222-3333-4444-555555555555.
```

```text
Set my active title role in group 11111111-2222-3333-4444-555555555555 to role UUID aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee.
```

```text
Add member 99999999-8888-7777-6666-555555555555 to role aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee in group 11111111-2222-3333-4444-555555555555.
```

## Good safety habits

1. Start with read operations (groups, members, roles, notices) before changing roles or titles.
2. Use UUID copy/paste carefully; one typo can target the wrong group.
3. Send a short test notice before sending an important estate-wide announcement.
4. Use verification-enabled prompts for role and ban changes when possible.

For exact tool names and structured role/group payloads, see **Advanced Guide -> Social, Groups, and Session Control**.
