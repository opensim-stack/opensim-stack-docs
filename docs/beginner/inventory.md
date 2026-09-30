# Beginner Inventory

Use these prompts to find, filter, and clean up items in your inventory.

Large inventories can take a while to search, so inventory listing is now a two-step flow:

1. Start an `InventoryList` task.
2. Read the materialized results with `InventoryListRetrieve`.
3. When you are done searching, call `InventoryListClear` to free the cached results.

## Quick start

```text
List my inventory recursively from the root folder.
```

```text
Show the first page of results from the inventory list task and search for items with Sign in the name.
```

```text
Clear the cached results for inventory list task 11111111-2222-3333-4444-555555555555.
```

## When to use inventory listing

Use inventory listing when you want to:

- find an item you already know is in inventory
- search a folder tree for a name
- check item types such as folders, objects, wearables, or scripts
- find recent or creator-specific items in a large inventory

## Typical workflow

1. Start `InventoryList` with `recursive=true` if you want to search subfolders.
2. Retrieve the results with `InventoryListRetrieve`.
3. Use filters like name, type, creator, or creation date to narrow the list.
4. If there are more results, use the returned cursor to continue.
5. Call `InventoryListClear` when you are finished.

## Examples

Find items containing a word in the name:

```text
Start an inventory list for my Objects folder, then show only items with Sign in the name.
```

Find a folder and its contents:

```text
List inventory in the folder 11111111-2222-3333-4444-555555555555 and include subfolders.
```

Look for recently created items:

```text
List items created after 2026-01-01T00:00:00Z in my inventory.
```

## Other useful inventory tools

Once you have found an item or folder, you can use tools such as:

- `InventoryCreateFolder`
- `InventoryRenameFolder`
- `InventoryRenameItem`
- `InventoryMoveItem`
- `InventoryCopyItem`
- `InventoryLinkItem`
- `InventoryDeleteItem`

## Tips

- If you do not see the item you expect, try listing recursively from the folder above it.
- If the list is long, use the cursor from the previous response to continue paging.
- Always clear the task results when you are done searching.
