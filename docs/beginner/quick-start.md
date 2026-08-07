# Beginner Quick Start

This path is for first-time users who want a working local stack with minimal setup.

## Prerequisites

- Docker Engine
- Docker Compose v2 (`docker compose`)
- An OpenSimulator viewer (Firestorm is commonly used)

!!! tip "New to Docker?"
    Start with Docker's short guides before continuing:
    <https://docs.docker.com/get-started/docker-overview/>

## 1) Prepare your environment file

From the `opensim-ai-docker` repository:

```bash
cp .env.example .env
```

Set at least `OPENSIM_HOSTNAME` in `.env`.

Minimal values to review before first run:

- `OPENSIM_HOSTNAME`
- `OPENSIM_REGION_PORT`
- `OPENSIM_ESTATE_OWNER_FIRST`
- `OPENSIM_ESTATE_OWNER_LAST`
- `OPENSIM_ESTATE_OWNER_PASSWORD`
- `OPENSIM_CONSOLE_USER`
- `OPENSIM_CONSOLE_PASS`

## 2) Start the stack

Source-mode compose (default):

```bash
docker compose up -d
```

Release-mode compose:

```bash
docker compose -f docker-compose.release.yml up -d
```

## 3) Log in with your viewer

Use these credentials unless you changed them in `.env`:

- Username: `Admin User`
- Password: `changeme`

Grid/login URL normally uses your region endpoint, for example:

```text
http://<OPENSIM_HOSTNAME>:<OPENSIM_REGION_PORT>
```

!!! tip "Viewer grid manager"
    Some viewers need you to manually add a custom grid. Look for "Grid Manager" or "Preferences -> Grids" in your viewer settings.

## 4) Start your first conversation with the bot

After login, find `Bot User` and open an IM conversation.

Try this first command:

```text
Place a cube prim 2 meters away and scale it x2.
```

Then try simple movement:

```text
Walk to me.
```

## 5) Optional: pick a stronger model

Use star commands in IM:

```text
*auth methods github-copilot
*auth github-copilot oauth 0
*auth github-copilot oauth-complete 0
*configure github-copilot/gpt-5.3-codex
```

If your provider needs API keys instead, see **Advanced Guide -> AI Configuration**.

## 6) Stop and reset commands

Stop services:

```bash
docker compose down
```

Full wipe including persistent volumes:

```bash
docker compose down -v
```

!!! warning "Data loss"
    `down -v` removes region/database state for this stack invocation.
