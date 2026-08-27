# Advanced Hardening

Default settings are convenient for local testing, not public exposure.

## Credentials you should change

Update these in `.env` before opening ports to the internet:

- `OPENSIM_CONSOLE_USER`
- `OPENSIM_CONSOLE_PASS`
- `MARIADB_PASSWORD`
- `MARIADB_ROOT_PASSWORD`
- `JANUS_API_TOKEN`
- `JANUS_ADMIN_TOKEN`

*Run `./generate-janus-tokens.sh` to update Janus credentials.*

## API and transport hardening

- Restrict host firewall exposure to only required ports.
- Keep private services on Docker internal network when possible.

## Password change operations after deployment

Reset an account password through console command path:

```text
reset user password First Last NewStrongPassword
```

Rotate console access credentials by updating `.env`, then restart affected services in web UI.
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
