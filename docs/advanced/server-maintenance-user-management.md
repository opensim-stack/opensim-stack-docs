# Server Maintenance and User Management

This page covers practical maintenance tasks that map closely to OpenSimulator console commands exposed through `opensim-console2mcp`.

## Region operations

Create a region:

```text
create region "Region Name" Regions/RegionName.ini
```

Show regions:

```text
show regions
```

Restart current region:

```text
restart
```

Schedule restart with notice:

```text
region restart notice "Maintenance in progress" 300 60 30
```

Abort a scheduled restart:

```text
region restart abort "Restart canceled"
```

## User management

Create user:

```text
create user First Last Password email@example.com
```

Show account:

```text
show account First Last
```

Reset password:

```text
reset user password First Last NewPassword
```

Kick user:

```text
kick user First Last --force "Maintenance"
```

## Import and export resources

Export region to OAR:

```text
save oar /workspace/exports/region-backup.oar
```

Import region from OAR:

```text
load oar /workspace/imports/region-restore.oar
```

Export user inventory (IAR):

```text
save iar First Last / Password /workspace/exports/user.iar
```

Import user inventory (IAR):

```text
load iar First Last / Password /workspace/imports/user.iar
```

## Terrain and scene maintenance

Set water height:

```text
set water height 25
```

Backup pending object changes:

```text
backup
```

Show scene stats:

```text
show scene
```

## Runtime operations from Docker host

Restart one service:

```bash
docker compose restart opensim
```

Restart full stack:

```bash
docker compose restart
```

Inspect recent logs:

```bash
docker compose logs --tail 200 opensim
```

!!! warning "High-impact commands"
    Commands like `load oar`, object deletion, or scene transforms can be destructive. Take backups first.
