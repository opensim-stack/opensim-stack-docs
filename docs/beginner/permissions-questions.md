# Beginner AI Permissions and Questions

The bot may ask permission before doing sensitive actions (file edits, command execution, or risky operations).

## Two ways prompts appear

1. In IM chat (default and always available).
2. In optional in-world popup dialogs via the LSL dialog bridge.

The dialog bridge is delivered via the bot attachment `The Cube Bot` (from inventory folder `Cube Bot IAR`) and can show multiple-choice prompts using `llDialog`.

If needed, run `*bridge install` to wear `Full Body Alpha` and attach `The Cube Bot` to `Spine`.

## Essential star commands

List pending permission requests:

```text
*permission list
```

Allow a request:

```text
*permission allow <permission-id>
```

Deny a request:

```text
*permission deny <permission-id>
```

List pending questions:

```text
*question list
```

Answer a question:

```text
*question answer <question-id> <your answer>
```

Reject a question:

```text
*question reject <question-id>
```

## Prompt visibility commands

```text
*prompt status
*prompt show effective
*prompt reload-project
```

## Safety defaults to know

- Permission prompts are interactive by design.
- Handler restrictions can limit who may control the bot.
- Dialog bridge trust checks can require known sender object/owner IDs.

!!! tip "If you are stuck"
    Run `*status` and then `*permission list` to see if the bot is waiting for your approval.
