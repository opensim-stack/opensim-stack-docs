# Advanced Hardening

Default settings are convenient for local testing, not public exposure.

## Credentials you should change

Update these in `.env` before opening ports to the internet:

- `MARIADB_PASSWORD`
- `MARIADB_ROOT_PASSWORD`
- `JANUS_API_TOKEN`
- `JANUS_ADMIN_TOKEN`

*Run `./generate-janus-tokens.sh` to update Janus credentials.*

## API and transport hardening

- Restrict host firewall exposure to only required ports.
- Keep private services on Docker internal network when possible.

For `opensim-metaverse2mcp` (LibreMetaverse 3.1.8+), set security options explicitly:

- `OPENSIM_SECURITY_VERIFY_SERVER_CERTIFICATES=true` (recommended baseline).
- `OPENSIM_SECURITY_CA_BUNDLE_PATH=/path/to/ca-bundle.pem` when your grid uses a private/internal CA.
- `OPENSIM_SECURITY_TRUST_CERTIFICATE=<sha256-fingerprint>` only when intentionally pinning a known server certificate.
- `OPENSIM_RESTRICT_TEXTURES_TO_MODEL_DIRECTORY=true` to keep Collada texture lookup constrained to model-local paths.

If you previously relied on implicit trust for self-signed certs, upgrades can break login until you provide a CA bundle or explicitly relax verification.

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
