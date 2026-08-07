# Documentation Plan

Use `mkdocs`, there is a requirements.txt with the components needed.

## Audience, Style eetc

 * Assume reader has some gaming knowledge, but not necessarily about virtual worlds like OpenSimulator or SecondLife.
 * Do assume limited knowledge of docker for stack maintenance tasks, but include links to good simple Docker resources for the uninitiated.
 * Don't assume coding or highly technical skills.
 * Use tip boxes to point out common gotchas or related features to explore  (need plugin)
 * Use code blocks for any chat commands. Add the "Copy" to clipboard button to all boxes (need plugin). 
 * Have pages, sections within those, and sub-sections. Try to not go deeper than this too often. 

## Pages

###  Introduction.

Describe then OpenSim AI Stack as a whole, and bullet point the 10 most significant features.

Have sections that describe each component of the stack (the main opensim container, console2mcp, metaverse2mcp and opencode). 

Draw a diagram (need plugin) showing how all the parts fit together, the stack components, the database, a link out to the hypergrid, the chatdot dialog bridge script, the link from OpenCode to an AI provider and model.

### Quick Start

Show Pre-requisites. Show docker basic compose commands and minimal environment variables.

Describe logging on to grid. Mention viewers may need to manage grid to add it.

Describe starting conversation with bot, and giving first commands.

### Movement

Give options on moving the bot around in the virtual world.

### Building

Give a good number of possible commands that could be used to build, scale
move, texture prims (example importing image from internet directly) 

Give some environment setting examples.

### Server Maintenance, User Management

Describe sever level operations (i.e. mainly console2mcp abilities, i.e. OpenSimulators). Creating regions, users, changing region parameters, importing and exporting resources. Restarting regions for maintenance etc.

### AI Permissions And Questions

Describe how permissions can either be in chat, or script dialog prompts if the bridge is installed (quick description of what bridge is).

Give the start commands related to permissions and prompts.

### AI Configuration

Details of "star command"s that are used to change providers, models, thinking mode etc.

Details of environment variables, and opencode.json that can be used to add more MCP servers and other opencode configuration.

Describe 3 places AGENTS.md can be. The default built in one (and show it as a code block, the one in /workspace - i think, might be /config, and the one that can be given to bot to put in inventory).  

### Hardening

Describe environment variables (passwords etc) that must be set, commands to change passwords etc.  

### Glossary

General metaverse terminology. OpenSimulator / SecondLife terminology. AI terminology and stack specific terminology. 