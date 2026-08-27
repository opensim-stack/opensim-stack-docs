# Beginner Quick Start

This path is for first-time users who want a working local stack with minimal setup.

## Prerequisites

- Operating system that supports Docker. Linux recommended, but Mac OS or Windows with WSL2 should work too
- Docker Engine
- Docker Compose v2 (`docker compose`)
- An OpenSimulator viewer (Firestorm is commonly used)

!!! tip "New to Docker?"
    Start with Docker's short guides before continuing:
    <https://docs.docker.com/get-started/docker-overview/>

## 1) Get The Composition

Create a working directory, e.g. `opensim-ai-stack`.

```
mkdir opensim-ai-stack
cd opensim-ai-stack
```

Get [docker-compose.yml](https://github.com/opensim-stack/opensim-ai-docker/blob/main/docker-compose.yml) from the root of the [stack composition repository](https://github.com/opensim-stack/opensim-ai-docker).

```bash

curl https://raw.githubusercontent.com/opensim-stack/opensim-ai-docker/refs/heads/main/docker-compose.yml -O docker-compose.yml
```

## 2) Start The Stack

You'll need to know the public or LAN hostname or IP address you are installing the stack on. E.g. run `hostname` command. We'll assume for the remainder of the example the result was `myhostname`. Replace with whatever your hostname actually is. 

```bash
OPENSIM_HOSTNAME=myhostname docker compose up -d
```

## 3) Setup Your Grid

Browse to .. 

```
http://myhostname:8993
```

Default username is `ConsoleUser` and password is `ConsolePass`. The *Setup Wizard* will now guide you through creating your grid, region, bot and user.

## 4) Log in with your viewer

Use the account username and password you just created in the setup wizard. Grid/login URL normally uses your region endpoint, for example:

```text
http://myhostname:9000
```

!!! tip "Viewer grid manager"
    Some viewers need you to manually add a custom grid. Look for "Grid Manager" or "Preferences -> Grids" in your viewer settings.

## 4) Start your first conversation with the bot

After login, find the bot and open an IM conversation.

Try this first command:

```text
Place a cube prim 2 meters away and scale it x2.
```

Then try simple movement:

```text
Walk to me.
```

## 5) Pick a stronger model

You will likely hit limits and limitations at some point with the free Opencode provider. To anything remotely complex you will need a stronger model.

For example, sign up for [Opencode Zen](https://opencode.ai/zen) for anything up to current frontier models, or as you are just starting out, [Opencode Zen](https://opencode.ai/go) for a more budget friendly pricing plan.

For lots more about AI providers and models, see **Advanced Guide -> AI Configuration**.

### Opencode Zen

```text
*auth opencode api 23k2345jksd80923509sdf0893245  # Replace with your actual API key
*configure opencode/gpt-5.3-codex
```

### Opencode Go

```text
*auth opencode api 23k2345jksd80923509sdf0893245  # Replace with your actual API key
*configure opencode/gpt-5.3-codex
```


## 6) Stop The Stack

Stop services:

```bash
docker compose down
```

