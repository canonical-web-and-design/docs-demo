---
layout: snappy-dev-default
title: Interfaces
permalink: /snappy-dev/interfaces/
---
# Interfaces
Interfaces allow snaps to communicate or share resources according to the protocol established by the interface.

Each connection has two ends, a **plug** (consumer) and a **slot** (provider). A plug and a slot can be connected if they use the same interface name. The connection grants the necessary permissions for snaps to operate according to the protocol.

Slots may support multiple connections to plugs. For example the OS snap exposes the network slot and all applications that can talk over the network connect their plugs there.

Interfaces are classified into two main groups:

 - Basic - ??
 - Advanced - ??

Interfaces are also further defined/identfied by:

 - usage: reserved (meaning?), common (meaning?)
 - auto-connect: yes/no - whether the plug is able to connect automatically to the slot or (something else needs to happen first)
