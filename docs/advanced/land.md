# Advanced Land Management

This page covers tool-level workflows for parcel, terrain, and estate administration.

## Parcel tools

- `ParcelGetCurrent`
- `ParcelGetByLocalId`
- `ParcelSetInfo`
- `ParcelSetLanding`
- `ParcelAccessListGet`
- `ParcelEjectUser`
- `ParcelJoin`
- `ParcelSubdivide`
- `ParcelPermissionDiagnostics`

## Terrain tools

- `TerrainHeightmapSample`
- `TerrainHeightmapExportRaw`
- `TerrainHeightmapImportRaw`
- `TerrainPatchCacheVerify`
- `TerrainPatchDiffRaw`
- `TerrainPatchApplyOffset`
- `TerrainPatchApplyOffsetRaw`
- `TerrainTerraform`

## Estate/admin tools

- `EstateGetInfo`
- `EstateGetCovenant`
- `EstateRestartRegion`
- `EstateCancelRestart`
- `EstateBroadcastMessage`
- `EstateRestartScheduleGet`
- `EstateRestartScheduleSet`

## Recommended operation order

1. Inspect current state (`ParcelGetCurrent`, `EstateGetInfo`).
2. Apply minimal change (`ParcelSetInfo`, `ParcelSetLanding`, `TerrainTerraform`).
3. Re-read state and confirm behavior.
4. Announce impact before disruptive actions (restart/schedule changes).

## Prompt examples for precise control

```text
Get parcel by local ID 42 with access lists included.
```

```text
Update parcel 42 name to Main Landing, set media URL to https://example.com/screen.
```

```text
Set parcel 42 landing type to direct.
```

```text
Run parcel permission diagnostics for parcel 42.
```

```text
Join parcels in bounds west=96 south=96 east=160 north=160.
```

```text
Subdivide parcels in bounds west=96 south=96 east=128 north=128.
```

```text
Sample terrain heights with step 8 and report missing cache points.
```

```text
Terraform parcel 42 with action smooth and brush large.
```

```text
Export terrain heightmap to /workspace/state/region-terrain.r32
```

```text
Import terrain heightmap from /workspace/state/region-terrain.r32
```

```text
Verify terrain patch cache at step 8 with minimum coverage ratio 0.9 and timeout 20 seconds.
```

```text
Diff terrain source current vs /workspace/state/region-terrain.r32 with min delta 0.05 and max samples 20.
```

```text
Apply terrain patch offset in bounds west=96 south=96 east=128 north=128 with delta 0.5 meters.
```

```text
Apply terrain patch offset from /workspace/state/base-terrain.r32 in bounds west=96 south=96 east=128 north=128 with delta 0.5 meters.
```

```text
Set weekly restart schedule for tue,thu at 02:15 UTC.
```

## Safe parcel ops playbook

Use this sequence to reduce mistakes and permission surprises:

1. Inspect target parcel and permission hints.
2. Confirm exact bounds and impact with the user.
3. Execute one structural change (join or subdivide).
4. Re-read parcel state and report what changed.

Example prompt sequence:

```text
Get parcel by local ID 42 with access lists included.
```

```text
Run parcel permission diagnostics for parcel 42 and summarize blockers.
```

```text
Subdivide parcels in bounds west=96 south=96 east=128 north=128.
```

```text
Get parcel by local ID 42 again and confirm landing, media, and access-list state.
```

## Notes and current limitations

- Terrain sampling reads simulator-cached patches; missing samples usually mean the patch cache is incomplete.
- If cache coverage is 0%, `TerrainHeightmapExportRaw` now fails instead of writing a misleading all-zero file.
- Terraform now uses a cache-safe reference-height fallback when terrain patch cache is incomplete.
- Patch-level workflows are available: verify cache coverage, diff RAW sources, and apply bounded offsets.
- For cache-cold sessions, prefer `TerrainPatchApplyOffsetRaw` with a known `.r32` source file/URL.
- Access list support is read-focused in current MCP flows.
- Estate operations depend on simulator capabilities and your estate permission level.

!!! tip "Prefer capability-aware retries"
    If a call fails, first re-check capability availability and privileges, then retry with narrower scope.
