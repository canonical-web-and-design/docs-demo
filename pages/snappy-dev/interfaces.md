---
layout: snappy-dev-default
title: Interfaces
permalink: /snappy-dev/interfaces/
---
# Interfaces
Interfaces provide a mechanism to enable snaps to communicate or share resources, according to the protocol established by the interface.

Each interface connection has two ends, a **plug** (consumer) and a **slot** (provider). A plug and a slot can be connected if they use the same interface name. The connection grants the necessary permissions for snaps to operate according to the protocol.

Slots can accept multiple connections from plugs. For example, the OS snap exposes the `network` slot and all applications that need to communicate over the network connect their plugs there. If necessary a slot can limit the number of connected plugs to one. 

Interface can either auto-connect or require the device user to explicitly enable the connection for a snap, using:

    ` $ snap connect <snap>:<plug> <snap>:<slot>`

In addition, future enhancements may provide for the gadget snap to connect snaps to interfaces -- so that preinstalled snap get their interfaces without the need for a manaul connection. 

A complete list of interfaces is provided in [List of Interfaces](../interfaces_list "Interfaces list"). You can also discover a list of interfaces available on a system and the snaps using them with `$ snap interfaces` or use the command to get more specific information, including:

- `$ snap interfaces <snap>` to find the slots offered and plugs used by the specified snap.
- `$ snap interfaces <snap>:<slot or plug>` for details of only the specified slot or plug.
- `$ snap interfaces -i=<interface> [<snap>]` to get a filtered list of  plugs and/or slots.
