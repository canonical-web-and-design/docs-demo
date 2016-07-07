---
layout: snappy-dev-default
title: Using Interfaces
permalink: /snappy-dev/using_snaps_interfaces/
---
# Using Interfaces

Most snaps will use at least one [interface](../interfaces). They'll use them to get access to OS or device features, or use information or functions offered by another application or service. In using and working with interfaces you need to be able to discover the interfaces available or required by a snap, and connect snaps to their interfaces, when they don't do it automatically.

## Discovering interfaces used or needed

You can discover a list of interfaces used or needed by a snap using `$ snap interfaces` as follows:

- `$ snap interfaces <snap>` to find the slots offered and plugs used by the specified snap.
- `$ snap interfaces <snap>:<slot or plug>` for details of only the specified slot or plug.
- `$ snap interfaces -i=<interface> [<snap>]` to get a filtered list of plugs and/or slots. 

## Connecting to interfaces

Interfaces can either auto-connect or require the device user to explicitly enable the connection for a snap, using:

` $ snap connect <snap>:<plug> <snap>:<slot>`

In addition, future enhancements may provide for the gadget snap to connect snaps automatically to manual interfaces – so that preinstalled snaps get their interfaces without the need for a manual connection.

Details of whether an interface connects automatically or not are provided in the [References section's List of Interfaces](../interfaces_list).