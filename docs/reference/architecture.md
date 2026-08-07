# Architecture Diagram

This diagram shows how the stack components fit together, including the database, hypergrid, dialog bridge, and external AI provider/model.

```mermaid
%%{init: {'flowchart': {'nodeSpacing': 55, 'rankSpacing': 110, 'diagramPadding': 16}}}%%
flowchart TB
    User["Viewer user"] -->|"IM commands"| BotAvatar["Bot avatar in OpenSimulator"]

    subgraph DockerHost["Docker Compose Stack"]
      direction TB

      subgraph OpenSimSide["OpenSim Side"]
        direction LR
        OpenSim["opensim container - OpenSimulator runtime"]
        DB[(MariaDB)]
        OpenSimInit["opensim-init config bootstrap"]
      end

      subgraph MCPBridgeSide["MCP Bridge Side"]
        direction LR
        ConsoleMCP["opensim-console2mcp MCP HTTP"]
        MetaMCP["opensim-metaverse2mcp MCP HTTP and bot session"]
      end

      subgraph AISide["AI Side"]
        direction LR
        OpenCode["opensim-opencode Opencode server"]
        OpenCodeInit["opensim-opencode-init generated opencode.json"]
      end
    end

    Hypergrid["Hypergrid destinations"] <-->|"teleports"| OpenSim
    OpenSimInit --> OpenSim
    OpenSim --> DB

    OpenSim -->|"REST console"| ConsoleMCP
    MetaMCP -->|"bot login and world actions"| OpenSim

    OpenCodeInit --> OpenCode
    OpenCode <-->|"MCP tools"| ConsoleMCP
    OpenCode <-->|"MCP tools"| MetaMCP

    Provider["AI provider and model (GitHub Copilot, OpenAI, local)"] <-->|"API auth and model calls"| OpenCode

    DialogBridge["LSL dialog bridge object (optional)"] <-->|"private chat protocol"| MetaMCP
    DialogBridge -->|"llDialog prompts"| User
```

## Data flow summary

1. You send bot instructions via in-world IM.
2. `opensim-metaverse2mcp` routes the text to Opencode chat sessions.
3. Opencode decides which MCP tools to call.
4. Tool calls go to either `opensim-console2mcp` (server admin) or `opensim-metaverse2mcp` (in-world actions).
5. Results return back through Opencode and are sent to you in-world.

!!! tip "Bridge script is optional"
    The LSL dialog bridge is optional. Without it, permission questions still appear in IM and can be answered with star commands.
