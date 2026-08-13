# Beginner Building

Use these simple IM prompts to start creating with the bot.

## Create and shape prims

```text
Create a cube in front of me.
```

```text
Scale that cube to 2 by 2 by 2.
```

```text
Rotate it 45 degrees on the Z axis.
```

## Rename and organize

```text
Name this prim Welcome Cube.
```

```text
Create three matching cubes in a row.
```

## Inspect before editing

```text
Inspect the selected prim and show creator, permissions, sale, and sit details.
```

```text
Refresh object properties for that prim, wait 5 seconds, then inspect full shape and light/flexible/sculpt details.
```

Use the refresh-style prompt when object metadata looks stale or incomplete.

## Edit detailed shape and effects

```text
Set that prim hollow to 0.25 and taper X to -0.2.
```

```text
Give this prim a gentle twist of 0.15 and set skew to 0.1.
```

```text
Turn on a soft white light on this prim with intensity 0.6 and radius 8.
```

```text
Enable flexible mode with softness 2, tension 6, and wind sensitivity 3.
```

## Linksets and grouped edits

```text
Inspect this object's linkset and show me the root and child prim IDs.
```

```text
Make localId 5678 the new root for this linkset.
```

```text
Move child links 5678 and 9012 up by 0.2 meters and rotate them 10 degrees on Z.
```

## Permissions and sale basics

```text
Set next-owner permissions on this object to copy and transfer on, modify off.
```

```text
Put this object for sale as a copy for 25 Linden dollars.
```

```text
Take this object off the market.
```

```text
Assign this object to group <group-uuid>, share with group, and deed to group.
```

## Find objects by parcel or status

```text
List objects in parcel local ID 123.
```

```text
Find scripted objects in this parcel.
```

```text
Find physical objects owned by avatar <owner-uuid>.
```

## Store and wallet basics

```text
Check the pay prices for this vendor object.
```

```text
Buy this object as a copy for 0 dollars.
```

```text
Show my current wallet balance.
```

```text
Pay avatar <avatar-uuid> 1 dollar and add memo "tip".
```

## Texture examples

Apply a simple texture workflow:

```text
Apply a brick texture to the selected prim.
```

Import an image from the web and apply it:

```text
Download an image from https://example.com/texture.jpg and use it as the prim texture.
```

!!! tip "Start in a sandbox area"
    When learning build prompts, practice in a region where mistakes are safe.

## Environment examples

```text
Make the sky warmer and brighter.
```

```text
Set water a little darker blue.
```

For raw environment payloads and precise tool calls, see **Advanced Guide -> Building and Environment**.
