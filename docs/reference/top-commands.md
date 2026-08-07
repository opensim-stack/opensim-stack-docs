# Curated Top Commands

This is a practical short list for daily operations.

## Bot chat star commands (AI control)

```text
*help
*status
*cancel
*providers
*models
*configure <provider>
*configure model <provider/model-id>
*configure thinking <low|medium|high|off>
*permission list
*permission allow <permission-id>
*permission deny <permission-id>
*question list
*question answer <question-id> <text>
*session create <title>
*session list
*session use <session-id>
```

## OpenSimulator user/admin commands

```text
create user First Last Password email@example.com
show account First Last
reset user password First Last NewPassword
kick user First Last --force "Maintenance"
show users full
show grid users online
```

## Region and simulator operations

```text
show regions
show region
create region "Region Name" Regions/RegionName.ini
change region Region Name
restart
region restart notice "Maintenance in 5 minutes" 300 60 30
region restart abort "Canceled"
show scene
show stats all
```

## Archiving and backup commands

```text
save oar /workspace/exports/region.oar
load oar /workspace/imports/region.oar
save iar First Last / Password /workspace/exports/user.iar
load iar First Last / Password /workspace/imports/user.iar
backup
```

## Terrain and environment commands

```text
terrain stats
terrain load /workspace/imports/terrain.r32
terrain save /workspace/exports/terrain.r32
set water height 25
```

## Docker operational commands

```bash
docker compose ps

docker compose logs -f opensim

docker compose restart opensim

docker compose down

docker compose down -v
```

!!! tip "Use safe sequence for risky changes"
    Export OAR first, run the change, verify, and export again after success.
