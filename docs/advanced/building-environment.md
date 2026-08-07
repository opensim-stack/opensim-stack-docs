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
