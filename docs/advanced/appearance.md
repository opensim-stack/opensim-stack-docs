# Advanced Appearance and Wearables

This page documents tool-level outfit, wearable, and attachment control in `opensim-metaverse2mcp`.

## Core appearance tool set

- `AppearanceListWorn`
- `AppearanceWearFolder`
- `AppearanceSaveCurrentOutfit`
- `AppearanceWearWearableItem`
- `AppearanceRemoveWearableItem`
- `AppearanceRemoveWearablesByType`
- `AppearanceAttachItem`
- `AppearanceSetAttachmentPointMapping`
- `AppearanceListAttachmentPointMappings`
- `AttachmentResolveObject`
- `AppearanceDetachItem`
- `AppearanceGetAttachedItemTransform`
- `AppearanceSetAttachedItemTransform`
- `AppearanceRebake`
- `AppearanceVisualParamsList`
- `AppearanceVisualParamSet`
- `AppearanceBakeDiagnostics`

## Cube bot mood tools

- `MoodList`
- `SetBotMood`

These tools control the cube-bot emoter attachment by routing mood messages through the dialog bridge object.

Prerequisites:

- Dialog bridge communication must already be established so a trusted bridge object is pinned.
- Mood names map to texture names in the bridge/cube attachment object inventory.

List available mood names:

```text
MoodList(includeUtilityTextures=false)
```

List all texture names (including utility textures like `base` and `cross`):

```text
MoodList(includeUtilityTextures=true)
```

Set mood by name:

```text
SetBotMood(emotion="happy")
```

Another example:

```text
SetBotMood(emotion="surprised")
```

!!! tip "Recommended sequence"
    Call `MoodList` first, pick one returned `moodNames` entry, then call `SetBotMood` with that exact name.

## Outfit folder workflows

Wear folder in replace mode:

```text
AppearanceWearFolder(folderId="11111111-2222-3333-4444-555555555555", replaceItems=true)
```

Wear folder in add mode:

```text
AppearanceWearFolder(folderId="11111111-2222-3333-4444-555555555555", replaceItems=false)
```

Save current outfit snapshot:

```text
AppearanceSaveCurrentOutfit(folderName="Evening Demo Look", parentFolderId="")
```

`AppearanceWearFolder` returns category conflict context so you can see where add/replace semantics overlap.

## Direct wearable controls

Wear by item UUID (replace same wearable slot):

```text
AppearanceWearWearableItem(itemId="11111111-2222-3333-4444-555555555555", replaceExistingSlot=true)
```

Remove a specific worn wearable item:

```text
AppearanceRemoveWearableItem(itemId="11111111-2222-3333-4444-555555555555")
```

Remove by wearable type:

```text
AppearanceRemoveWearablesByType(wearableType="Shirt", removeAllLayers=true)
```

## Attachment point mapping

Attach an inventory object:

```text
AppearanceAttachItem(itemId="11111111-2222-3333-4444-555555555555", attachmentPoint="RightHand", replace=false)
```

List currently worn item-to-point mappings:

```text
AppearanceListAttachmentPointMappings()
```

Remap attachment point by reattach:

```text
AppearanceSetAttachmentPointMapping(itemId="11111111-2222-3333-4444-555555555555", attachmentPoint="Spine", replace=true)
```

Detach by item UUID:

```text
AppearanceDetachItem(itemId="11111111-2222-3333-4444-555555555555")
```

## Attached item transform edits

Read transform snapshot:

```text
AppearanceGetAttachedItemTransform(itemId="11111111-2222-3333-4444-555555555555")
```

Request position and yaw update:

```text
AppearanceSetAttachedItemTransform(
  itemId="11111111-2222-3333-4444-555555555555",
  positionX=0.0,
  positionY=0.05,
  positionZ=0.02,
  yawDegrees=15,
  childOnly=true,
  uniformScale=false
)
```

Request uniform scale update:

```text
AppearanceSetAttachedItemTransform(
  itemId="11111111-2222-3333-4444-555555555555",
  scaleX=1.1,
  scaleY=1.1,
  scaleZ=1.1,
  childOnly=true,
  uniformScale=true
)
```

!!! tip "Transform update behavior"
    Attachment transform updates are requested asynchronously through simulator object updates. Re-query state after a short delay to confirm final applied values.

## Resolve attachment object IDs for task inventory

When you need prim `task inventory` from a worn attachment (for example the bridge prim), first resolve the attachment item UUID to the currently active in-world object UUID/local ID.

Resolve one worn attachment item:

```text
AttachmentResolveObject(itemId="11111111-2222-3333-4444-555555555555")
```

List task inventory using local ID:

```text
TaskInventoryList(objectLocalId=123456, objectId="11111111-2222-3333-4444-555555555555", maxResults=200)
```

List task inventory using object UUID only (tool resolves current local ID from simulator cache):

```text
TaskInventoryList(objectLocalId=0, objectId="11111111-2222-3333-4444-555555555555", maxResults=200)
```

`AppearanceListWorn` also includes attachment `objectId` and `objectLocalId` when currently available, so you can often skip a separate resolve step.

## Appearance refresh

Normal refresh:

```text
AppearanceRebake(forceRebake=false)
```

Forced rebake:

```text
AppearanceRebake(forceRebake=true)
```

## Visual parameter controls

List all editable shape sliders:

```text
AppearanceVisualParamsList(wearable="shape", nameContains="", editableOnly=true)
```

Filter by slider name:

```text
AppearanceVisualParamsList(wearable="", nameContains="nose", editableOnly=true)
```

Set a slider by param ID:

```text
AppearanceVisualParamSet(paramId=33, paramName="", wearable="", value=0.65, clampToRange=true)
```

Set a slider by exact param name:

```text
AppearanceVisualParamSet(paramId=null, paramName="Nose Size", wearable="shape", value=0.4, clampToRange=true)
```

Notes:

- `AppearanceVisualParamSet` only accepts editable group-0 parameters.
- Name-based selection can be ambiguous; pass `wearable` or `paramId` to disambiguate.
- Each set request triggers a rebake/update workflow.

## Bake diagnostics

Read current bake state only:

```text
AppearanceBakeDiagnostics(requestCacheProbe=false, cacheProbeTimeoutMs=1500)
```

Run a cache probe and include reply timing:

```text
AppearanceBakeDiagnostics(requestCacheProbe=true, cacheProbeTimeoutMs=2500)
```

Diagnostics include server-baking mode, manager busy state, visual-param counts, and per-bake-slot texture IDs.

## Operational guidance

- Prefer UUIDs from inventory/worn-list outputs to avoid name ambiguity.
- For scripted outfit pipelines, save known-good snapshots with `AppearanceSaveCurrentOutfit`.
- Use `AppearanceListWorn` before and after changes when debugging layered wearable behavior.
- For slider edits, call `AppearanceVisualParamsList` first, then `AppearanceVisualParamSet`, then `AppearanceBakeDiagnostics` to verify baked slot updates.
- For cube expression changes, call `MoodList` before `SetBotMood` to avoid unknown texture names.
