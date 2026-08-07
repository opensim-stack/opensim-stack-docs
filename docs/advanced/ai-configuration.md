# Advanced AI Configuration

The bot supports live configuration in IM through star commands, plus startup defaults through environment variables.

## Star commands for runtime control

List providers and models:

```text
*providers
*providers configured
*models
*models <provider>
```

Authenticate provider:

```text
*auth methods <provider>
*auth <provider> api <api-key>
*auth <provider> oauth 0
*auth <provider> oauth-complete 0
```

Select provider/model:

```text
*configure <provider-name-or-id>
*configure model <provider/model-id>
*configure thinking <low|medium|high|off>
*configure reset
```

Session controls:

```text
*session create My Build Session
*session list
*session use <session-id>
*session summarize current
*session delete <session-id> --force
```

## Startup defaults via environment

Useful metaverse/opencode variables:

- `OPENCODE_INITIAL_PROVIDER`
- `OPENCODE_INITIAL_MODEL`
- `OPENCODE_REQUEST_TIMEOUT_SECONDS`
- `OPENCODE_HANDLER_FIRSTNAME`
- `OPENCODE_HANDLER_LASTNAME`
- `PROMPT_HANDLING_ENABLED`
- `PROMPT_PROJECT_AGENTS_ENABLED`
- `PROMPT_PROJECT_AGENTS_FILE`

## MCP endpoint wiring

Main generated values in `opencode.json` are sourced from:

- `OPENCODE_MCP_URL` (console MCP)
- `OPENCODE_METAVERSE_MCP_URL` (metaverse MCP)

Default in-stack endpoints:

- `http://opensim-console2mcp:8997/mcp`
- `http://opensim-metaverse2mcp:8999/mcp`

## Adding more MCP servers

You can extend `opencode.json` with additional remote MCP servers.

Example pattern:

```json
{
  "mcp": {
    "local_host_mcp": {
      "type": "remote",
      "url": "http://opensim-console2mcp:8997/mcp",
      "enabled": true
    },
    "metaverse_mcp": {
      "type": "remote",
      "url": "http://opensim-metaverse2mcp:8999/mcp",
      "enabled": true
    },
    "extra_tools": {
      "type": "remote",
      "url": "http://my-extra-mcp:8080/mcp",
      "enabled": true
    }
  }
}
```

!!! tip "Prefer runtime changes first"
    Use star commands for day-to-day provider/model switches. Use env or `opencode.json` for stable baseline defaults.
