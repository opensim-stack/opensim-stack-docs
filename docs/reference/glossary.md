# Glossary

## Metaverse and OpenSimulator terms

**Avatar**
A user representation in a virtual world.

**Region**
A simulator-hosted area of the world (often 256m x 256m in classic setups).

**Grid**
A collection of regions and shared services (users, inventory, assets).

**Hypergrid**
Protocol for teleporting between independent OpenSim-compatible grids.

**Estate**
Administrative grouping of region settings and ownership controls.

**Prim**
Basic 3D building block object used to create structures.

**IAR**
Inventory Archive file format for user inventory export/import.

**OAR**
OpenSimulator Archive file format for full region export/import.

## AI and MCP terms

**AI provider**
Service that hosts models (for example, cloud or local model providers).

**Model**
Specific AI engine used to process prompts and generate tool actions.

**MCP (Model Context Protocol)**
Protocol for exposing tools and resources to AI runtimes.

**Tool call**
A structured action request made by AI to an MCP server.

**Prompt layer**
One source of instruction text (built-in, project `AGENTS.md`, or in-world notecard).

**Star command**
Chat command prefixed with `*` used by the bot for runtime control.

## Stack-specific terms

**`opensim-console2mcp`**
Service that bridges OpenSim REST console commands to MCP.

**`opensim-metaverse2mcp`**
Service that controls the bot avatar and exposes in-world tools over MCP.

**`opensim-opencode`**
Containerized Opencode server used as the AI runtime in this stack.

**Dialog bridge**
Optional LSL script object that shows AI questions as in-world popup dialogs.

**Handler avatar**
Configured avatar identity allowed to control the bot when handler restrictions are enabled.
