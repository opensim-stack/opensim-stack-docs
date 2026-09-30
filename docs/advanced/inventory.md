# Advanced Inventory

This page covers inventory search, paging, and cache management in `opensim-metaverse2mcp`.

## Inventory list workflow

`InventoryList` now starts a background BotTask instead of returning results immediately.

That matters because:

- recursive inventory scans can be slow on large inventories
- the bot materializes the results once the query finishes
- callers can retrieve the cached result set multiple times with different filters
- callers should clear cached results after they finish searching

The companion tools are:

- `InventoryList` — start the task and get a handle
- `InventoryListRetrieve` — query the materialized results
- `InventoryListClear` — release the cached results for that handle

## Recommended sequence

1. Start `InventoryList` with `recursive=true` for broad searches or `recursive=false` for a single folder.
2. Wait for the task to complete, or watch the usual runtime events for completion.
3. Call `InventoryListRetrieve` with the returned task handle.
4. Apply filters such as `nameContains`, `type`, `createdAfterUtc`, `createdBeforeUtc`, and `creatorId`.
5. Page through results with the `cursor` value.
6. Call `InventoryListClear` when you are finished.

## Example patterns

Search a whole tree for objects with a name fragment:

```text
Start an inventory list task for the root folder recursively, then retrieve entries with name containing Bridge and type object.
```

List a specific folder and continue paging:

```text
Retrieve page 1 from inventory list task 11111111-2222-3333-4444-555555555555 with page size 100.
```

```text
Retrieve the next page using cursor b2Zmc2V0OjEwMA== and page size 100.
```

Search by creation time or creator:

```text
Retrieve inventory results created after 2026-01-01T00:00:00Z by creator 11111111-2222-3333-4444-555555555555.
```

## Filtering behavior

`InventoryListRetrieve` uses the same filter model that the old one-shot inventory query used:

- `maxResults` limits the number of matched entries considered
- `pageSize` controls how many entries you see per page
- `nameContains` is a case-insensitive substring match
- `type` matches folder kind, asset type, or inventory type
- `createdAfterUtc` and `createdBeforeUtc` only apply to items
- `creatorId` only applies to items
- `cursor` resumes from a prior page

## Cache management

Materialized inventory results are held in memory by task handle.

Best practices:

- retrieve results soon after the task completes
- clear old results with `InventoryListClear`
- do not keep handles around longer than needed
- if you are running many searches, expect older cached results to be evicted once the configured cache limit is reached

## Practical examples

Find all folders and items under a parent folder:

```text
Start an inventory list for folder 11111111-2222-3333-4444-555555555555 recursively.
```

List only items with a specific creator:

```text
Retrieve results from task 11111111-2222-3333-4444-555555555555 with creator 11111111-2222-3333-4444-555555555555.
```

Clear results after a search session:

```text
Clear inventory list task 11111111-2222-3333-4444-555555555555.
```

## Related inventory tools

For inventory organization and item lifecycle work, see:

- `InventoryCreateFolder`
- `InventoryRenameFolder`
- `InventoryRenameItem`
- `InventoryMoveFolder`
- `InventoryMoveItem`
- `InventoryMoveMany`
- `InventoryCopyItem`
- `InventoryLinkItem`
- `InventoryDeleteFolder`
- `InventoryDeleteItem`
- `InventoryDeleteMany`
