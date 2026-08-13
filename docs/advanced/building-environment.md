# Advanced Building and Environment

This page focuses on tool-level building workflows and environment payload control.

## High-value prim tools

- `PrimCreate`
- `PrimSetPosition`
- `PrimSetScale`
- `PrimSetRotation`
- `PrimSetTexture`
- `PrimSetFaceParams`
- `PrimNudgeFaceUv`
- `PrimApplyUvPreset`
- `PrimTileUv`
- `PrimTileUvNonUniform`
- `PrimLink`
- `PrimUnlink`
- `PrimClone`
- `PrimInspect`
- `PrimFetchProperties`
- `PrimSetBuildParams`
- `PrimSetFlexible`
- `PrimSetLight`
- `PrimSetSculpt`
- `PrimInspectLinkset`
- `PrimSetLinksetRoot`
- `PrimReorderLinkset`
- `PrimBulkAdjustLinks`
- `PrimSetNextOwnerPermissions`
- `PrimSetSaleInfo`
- `PrimSetGroupOwnership`
- `PrimQueryObjects`
- `PrimRequestPayPrice`
- `PrimBuy`
- `WalletGetBalance`
- `Pay`
- `PrimFindByName`
- `PrimListNearby`

## Prompt examples for precise builds

```text
Create a 1x1x1 cube named Marker-A at 130,130,25.
```

```text
Clone Marker-A three times, place each clone 2 meters apart on X.
```

```text
Apply a texture from https://example.com/panel.png and tile it 4x4 on face 0.
```

```text
Rotate Marker-A by 90 degrees around Z and set scale to 1,2,0.5.
```

```text
Fetch fresh properties for prim localId 1234, wait 5 seconds, and report permissions, sale info, sit data, and full path/profile shape parameters.
```

```text
Set prim 1234 path cut to 0.1..0.9, hollow to 0.2, taper X to -0.3, taper Y to 0.1, and profile hole to Circle.
```

```text
Enable light on prim 1234 with RGB 1,0.95,0.8 intensity 0.7 radius 12 cutoff 60 falloff 0.8.
```

```text
Enable flexible on prim 1234 with softness 2, tension 5, drag 2, gravity -1, wind 3.
```

```text
Enable sculpt on prim 1234 as Mesh with texture UUID <uuid>, mirror false, invert false.
```

```text
Inspect the full linkset tree for localId 1234 and show root, parent IDs, and per-link order.
```

```text
Set linkset root to localId 5678 for the object that contains localId 1234.
```

```text
Reorder linkset members to 1234,5678,9012 with root 9012.
```

```text
Bulk-adjust links 5678,9012 by delta position 0,0,0.2 and yaw +10 degrees using child-only edits.
```

```text
Set next-owner permissions on 1234,5678 to copy=true modify=false transfer=true.
```

```text
Set object 1234 for sale as Copy at price 50.
```

```text
Clear for-sale state on object 1234.
```

```text
Assign 1234,5678 to group <group-uuid>, share with group, and deed to group.
```

```text
Query objects in parcel local ID 123 where scriptedOnly=true and physicalOnly=false.
```

```text
Query objects owned by <owner-uuid> with physicalOnly=true across the current simulator cache.
```

```text
Request pay prices for object localId 1234 and show default/button values.
```

```text
Buy object localId 1234 with sale type Copy at price 0.
```

```text
Refresh and report my wallet balance.
```

```text
Pay avatar <avatar-uuid> amount 1 with memo "tip".
```

## Freshness-aware prim inspection

- `PrimInspect` reads from current simulator cache only.
- `PrimFetchProperties` explicitly requests family + full object properties, waits up to `waitTimeoutSeconds`, and includes freshness metadata in the response.
- Rich inspect output now includes:
  - detailed path/profile values (cut, taper, twist, shear, skew, hollow, revolutions)
  - permissions masks and sale info
  - sit/touch labels and sittable hint
  - flexible/light/sculpt details (including mesh detection)

## Shape/edit parameter notes

- `PrimSetBuildParams` clamps values to safe protocol ranges used by shape packing.
- Use `PrimFetchProperties` after `PrimSetBuildParams` when you need fresh verification values.
- Use `PrimSetLight`, `PrimSetFlexible`, and `PrimSetSculpt` with `enabled=false` to disable those extra params.

## Linkset-level workflows

- `PrimInspectLinkset` returns the full root+children tree from any member local ID.
- `PrimSetLinksetRoot` and `PrimReorderLinkset` use relink behavior (root prim is linked last).
- `PrimBulkAdjustLinks` is the fastest way to apply coordinated offset/rotation/scale changes to selected child links.

## Permissions and ownership notes

- `PrimSetNextOwnerPermissions` updates copy/modify/transfer flags for next owner only.
- `PrimSetSaleInfo` supports explicit for-sale setup and clearing for-sale state.
- `PrimSetGroupOwnership` sets object group, applies/clears group-share permissions, and can request deed to group.
- Group deed requests depend on region rights and object/share constraints; use `PrimFetchProperties` after updates to verify results.

## Parcel object discovery

- `PrimQueryObjects` filters objects by parcel local ID, owner UUID, scripted status, and physical status.
- When filtering by parcel, use `forceRefreshParcelMap=true` if parcel boundaries may have changed recently.
- Returned payload includes each matched object's local/parent IDs, owner ID, scripted/physical flags, and position.

## Commerce tools (minimal pass)

- `PrimRequestPayPrice` queries the simulator pay dialog pricing payload for an object UUID/local ID.
- `PrimBuy` sends an object purchase request and supports explicit 0-price (`L$0`) purchases.
- `WalletGetBalance` can return cached balance or force a refresh request before returning.
- `Pay` submits a money transfer request to avatar/object/group targets.

## UV and texturing tips

- Use `PrimApplyUvPreset` for fast outcomes (`fit`, `reset`, `tile2x2`, `rotate90`, and more).
- Use `PrimTileUvNonUniform` when texture stretch differs by axis.

## Environment control tools

- `EnvGetRegion`
- `EnvGetParcel`
- `EnvSetRegionRaw`
- `EnvSetParcelRaw`
- `EnvResetRegion`
- `EnvResetParcel`
- `EnvGetLegacy`
- `EnvSetLegacyRaw`
- `EnvResetLegacy`

## Environment payload workflow

1. Pull baseline payload.
2. Edit only required values.
3. Apply raw JSON payload.

Prompt example:

```text
Get region environment, reduce cloud shadow, then apply updated region environment.
```

Minimal payload shape example:

```json
{
  "day_length": 14400,
  "day_offset": 57600,
  "flags": 0,
  "day_cycle": {
    "type": "daycycle",
    "tracks": []
  }
}
```

!!! tip "Use baseline-first edits"
    Start from `EnvGetRegion` output instead of crafting large payloads from scratch.
