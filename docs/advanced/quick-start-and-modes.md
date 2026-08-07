# Advanced Quick Start and Modes

This guide focuses on mode selection, image strategy, and operational commands.

## Build modes

- **Source mode**: uses `docker-compose.yml` and `OPENSIM_SOURCE_IMAGE` by default.
- **Release mode**: uses `docker-compose.release.yml` and `OPENSIM_RELEASE_IMAGE` by default.

Both modes include the same sidecars (`opensim-console2mcp`, `opensim-metaverse2mcp`, `opensim-opencode`) and MariaDB.

## Compose entry points

Published images:

```bash
docker compose up -d
docker compose -f docker-compose.release.yml up -d
```

Local build helper scripts:

```bash
./run.sh
./run-release.sh
```

!!! tip "Local override files"
    Helper scripts use `docker-compose.local.yml` or `docker-compose.release.local.yml` to build local images while keeping compose wiring consistent.

## Minimal environment baseline

At minimum, set:

- `OPENSIM_HOSTNAME`
- `OPENSIM_REGION_PORT`
- `OPENSIM_CONSOLE_USER`
- `OPENSIM_CONSOLE_PASS`
- `OPENSIM_ESTATE_OWNER_PASSWORD`

For sidecars, verify:

- `MCP_PORT`
- `METAVERSE_MCP_PORT`
- `OPENCODE_PORT`
- `OPENSIM_LOGIN_FIRSTNAME`
- `OPENSIM_LOGIN_LASTNAME`
- `OPENSIM_LOGIN_PASSWORD`

## Service topology checks

Get status:

```bash
docker compose ps
```

Tail logs for key services:

```bash
docker compose logs -f opensim

docker compose logs -f opensim-console2mcp

docker compose logs -f opensim-metaverse2mcp

docker compose logs -f opensim-opencode
```

## Regenerate first-run config

If REST console or bootstrap config drifted due to old volumes:

```bash
docker compose down -v

docker compose up -d
```

## Port mapping defaults

- OpenSim: `9000/tcp` and `9000/udp` (host side uses `OPENSIM_REGION_PORT`)
- Console MCP: `8997/tcp`
- Metaverse MCP: `8999/tcp`
- Opencode HTTP: `8998/tcp`
