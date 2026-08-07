# OpenSim AI Stack Documentation

Welcome to the documentation suite for the OpenSim AI Docker stack.

This guide is written for people who enjoy games and virtual worlds, but may be new to OpenSimulator, Docker, or AI tooling.

!!! warning "Experimental project"
    This stack is still in active development. Back up your regions and configuration before trying major changes.

## What this stack is

The OpenSim AI Stack is a Docker Compose deployment that combines:

- OpenSimulator (the virtual world server)
- MariaDB (persistent data)
- `opensim-console2mcp` (admin command bridge)
- `opensim-metaverse2mcp` (in-world bot bridge)
- `opensim-opencode` (AI runtime and provider integration)

## Top 10 most significant features

1. Natural-language server administration through OpenSimulator console commands.
2. In-world bot avatar you can chat with by IM.
3. Bot movement tools: walk, fly, teleport, and stop actions.
4. Prim building tools: create, scale, rotate, texture, link, and inspect.
5. Inventory and asset workflows (upload, download, give, and policy control).
6. Environment controls for region and parcel lighting/weather profiles.
7. Runtime AI provider and model switching using star commands.
8. Prompt layering with project and in-world `AGENTS.md` support.
9. Optional in-world dialog bridge for AI questions and approvals.
10. Two runtime modes (source/release) with shared operational model.

## Choose your path

- If you are new to Docker and OpenSim, start with **Beginner Guide -> Quick Start**.
- If you are already comfortable with containers and operations, start with **Advanced Guide -> Quick Start and Modes**.

## Docker learning resources

If Docker is new to you, these short resources are a good starting point:

- Docker overview: <https://docs.docker.com/get-started/docker-overview/>
- Docker Compose intro: <https://docs.docker.com/compose/>
- Common Docker CLI reference: <https://docs.docker.com/reference/cli/docker/>

## Component quick descriptions

### OpenSimulator container

Runs your region simulator and exposes the world endpoint (default `9000` TCP/UDP). It is initialized with values from `.env` through the `opensim-init` service.

### `opensim-console2mcp`

Bridges OpenSimulator REST console endpoints into MCP tools so AI can issue admin and maintenance commands.

### `opensim-metaverse2mcp`

Logs in the bot avatar and exposes movement, building, inventory, environment, and chat-linked AI control over MCP HTTP.

### `opensim-opencode`

Runs Opencode server mode and uses generated `opencode.json` to connect to both MCP services.

## Next steps

- Architecture details: **Reference -> Architecture Diagram**
- First run: **Beginner Guide -> Quick Start**
- Security defaults and hardening: **Advanced Guide -> Hardening**
