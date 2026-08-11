# Beginner Content (Mesh Upload)

Use these prompts to upload 3D content from modern `.glb` or `.gltf` files.

## Before you upload

- Export from Blender as `.glb` (recommended single-file package) or `.gltf` with textures.
- Keep geometry mostly triangles for best compatibility.
- Keep textures reasonably sized (1024 max per side is a safe starting point).

## Inspect first (safe preflight)

```text
Inspect this model for upload readiness: /workspace/models/sign.glb.
```

```text
Run strict mesh inspection on /workspace/models/house.glb and tell me all warnings.
```

The bot uses `MeshInspectGltf` to report what will be uploaded, what may be skipped, and whether any textures failed to ingest.

## Upload examples

```text
Upload /workspace/models/sign.glb as inventory object named Town Sign with description Main plaza sign.
```

```text
Upload https://example.com/assets/fountain.glb as inventory object named Fountain with description Courtyard centerpiece.
```

If upload succeeds, you should get new inventory item and asset IDs.

## Practical beginner workflow

1. Inspect model (`MeshInspectGltf`).
2. Fix obvious issues (missing textures, non-triangle warnings).
3. Upload model (`MeshUploadGltf`).
4. Rez and inspect in-world.

## Manage uploaded objects (lifecycle)

After upload, these prompts help move objects through a clean edit loop:

```text
Return object local IDs 41201 and 41255 to owner inventory.
```

```text
Take a copy of object local IDs 41201,41255 into folder 2e4d6f1c-1111-2222-3333-444455556666.
```

```text
Take object local ID 41201 into my default Objects folder.
```

```text
Rez inventory object item 9d4c7f0a-1111-2222-3333-444455556666 at 128,128,25 with yaw 90, wait for object, select it after rez, then scale to 2,2,2.
```

These map to `PrimReturnToOwner`, `PrimTake`, and `PrimRezFromInventory`.

## Common fixes

- If strict inspection fails due to skipped primitives, convert/re-export the model with triangle faces.
- If textures fail, verify texture paths in the source package or use embedded `.glb` textures.
- If a model appears tiny or huge, adjust object scale in Blender and export again.

!!! tip "Use `.glb` for easiest sharing"
    `.glb` bundles geometry + textures in one file and usually avoids relative-path texture problems.
