# Beginner Land Basics

This page helps you make safe land-related changes with plain-language prompts.

## What you can do now

- Read parcel details for where you are standing.
- Update parcel name, description, music URL, and media URL.
- Configure parcel landing point behavior.
- View parcel allow and ban lists.
- Sample terrain heights and run terraform actions.
- Send region or estate broadcast messages (if your account has rights).

## Starter prompt examples

```text
Show the parcel details where I am right now.
```

```text
Rename this parcel to Welcome Plaza and set the description to Beginner sandbox area.
```

```text
Set parcel music URL to https://example.com/radio-stream
```

```text
Set this parcel landing type to landing point at 128,128,25.
```

```text
Show the ban list for parcel local ID 42.
```

## Terrain examples

```text
Sample terrain heights every 16 meters.
```

```text
Smooth terrain on parcel 42 with a medium brush.
```

!!! warning "Terraform is destructive"
    Terraform changes modify land shape. Test in sandboxes first and confirm permissions before running large edits.

## Estate/admin examples

```text
Show estate info for this region.
```

```text
Broadcast message to this region: Scheduled restart in 10 minutes.
```

```text
Set weekly restart schedule for mon,wed,fri at 03:30 UTC.
```

## Good safety habits

1. Ask the bot to read current parcel details before editing.
2. Change one property at a time so rollbacks are easier.
3. Use clear restart notices before scheduling or triggering restarts.

For low-level tool names and exact operation patterns, see **Advanced Guide -> Land Management**.
