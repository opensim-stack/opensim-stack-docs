# Advanced Hardening

Default settings are convenient for local testing, not public exposure.

## Credentials you should change

Update these in `.env` before opening ports to the internet:

- `OPENSIM_ESTATE_OWNER_PASSWORD`
- `OPENSIM_CONSOLE_USER`
- `OPENSIM_CONSOLE_PASS`
- `MARIADB_PASSWORD`
- `MARIADB_ROOT_PASSWORD`
- `OPENCODE_SERVER_PASSWORD`
- `OPENCODE_PASSWORD` (if using Basic auth path)

## API and transport hardening

- Set `METAVERSE_MCP_HTTP_BEARER_TOKEN` to protect metaverse MCP endpoint.
- Use strong credentials for Opencode server auth paths.
- Restrict host firewall exposure to only required ports.
- Keep private services on Docker internal network when possible.

## Bot control hardening

Use handler restrictions:

- `OPENCODE_HANDLER_FIRSTNAME`
- `OPENCODE_HANDLER_LASTNAME`

Use dialog bridge trust restrictions:

- `OPENCODE_LSL_DIALOG_BRIDGE_TRUSTED_OWNER_ID`
- `OPENCODE_LSL_DIALOG_BRIDGE_TRUSTED_OBJECT_ID`
- `OPENCODE_LSL_DIALOG_BRIDGE_REQUIRE_TRUSTED_SENDER=true`

## Password change operations after deployment

Reset an account password through console command path:

```text
reset user password First Last NewStrongPassword
```

Rotate console access credentials by updating `.env`, then restart affected services:

```bash
docker compose up -d

docker compose restart opensim opensim-console2mcp
```

## Network and host hygiene

- Use reverse proxy/TLS in front of exposed HTTP endpoints.
- Keep host OS patched.
- Back up volumes regularly before updates.
- Pin known-good image tags for production-like environments.

## Recovery and audit basics

- Export OAR/IAR on a schedule.
- Keep change logs for `.env` and compose overrides.
- Test restore procedure on a non-production stack.

!!! warning "No hardening is one setting"
    Security is layered: credentials, network limits, identity controls, and backup discipline all matter together.
