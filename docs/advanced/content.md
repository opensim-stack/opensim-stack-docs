# Advanced Content (Mesh Upload)

This page documents Collada-free mesh content workflows using modern `.glb` / `.gltf` sources.

## High-value content tools

- `MeshInspectGltf`
- `MeshUploadGltf`
- `AssetUploadInventory`
- `AssetDownload`

## Inspection modes

`MeshInspectGltf` supports strict and non-strict validation:

- Non-strict: reports diagnostics but still returns success when uploadable content exists.
- Strict: fails if any primitive would be skipped or if any texture ingest/transcode fails.

Prompt examples:

```text
Inspect /workspace/models/station.glb with strict mode enabled and return full diagnostics.
```

```text
Inspect /workspace/models/station.glb with strict mode disabled and summarize only the top warnings.
```

## Upload workflow (recommended)

1. Run strict inspection.
2. Resolve geometry and texture warnings.
3. Upload with final inventory name/description.
4. Verify appearance in-world and iterate.

Prompt examples:

```text
Inspect /workspace/models/bridge.glb in strict mode. If it passes, upload it as Bridge-A with description North canal bridge.
```

```text
Upload /workspace/models/panel.gltf as Control Panel with description Operations room panel.
```

## Texture ingestion behavior

During mesh processing:

- Existing JPEG2000 (`.jp2`, `.j2c`, `.j2k`) textures are passed through.
- Other common image formats (for example PNG/JPEG/TGA) are decoded and converted to JPEG2000.
- Images are normalized to power-of-two dimensions and capped at 1024x1024 before encoding.

This keeps uploaded textures compatible with typical simulator expectations.

## Failure patterns and remediation

- Skipped primitive warnings:
  - Cause: non-triangle primitive modes or invalid index ranges.
  - Fix: triangulate mesh before export and re-run strict inspection.

- Texture ingest/transcode failures:
  - Cause: unresolved URI paths, unsupported/corrupt image payloads, malformed data URIs.
  - Fix: prefer `.glb` with embedded textures or correct relative texture paths in `.gltf` packages.

- Unexpected world scale:
  - Cause: source scene scale mismatch.
  - Fix: apply transforms in authoring tool, re-export, re-inspect.

## Object lifecycle automation after upload

For iterative pipelines, treat upload and in-world placement as separate stages:

1. Upload candidate mesh to inventory.
2. Rez from inventory at a deterministic transform.
3. Apply optional post-rez scale.
4. Keep by taking/take-copy, or roll back by returning to owner.

Prompt examples:

```text
Take copy of local IDs 5102,5103 into folder 2e4d6f1c-1111-2222-3333-444455556666.
```

```text
Take local IDs 5102,5103 (move, not copy) into my default Objects folder.
```

```text
Rez inventory item 9d4c7f0a-1111-2222-3333-444455556666 at 130,124,28 with roll 0 pitch 0 yaw 180; wait for object and select it after rez.
```

```text
Return local IDs 5102,5103 to owner inventory.
```

Use `PrimTake` with `takeCopy=true` for non-destructive edits and `takeCopy=false` for move semantics.

!!! tip "Gate uploads with strict mode in production"
    For automated pipelines, run `MeshInspectGltf` strict mode before `MeshUploadGltf` to prevent partial or degraded uploads.
