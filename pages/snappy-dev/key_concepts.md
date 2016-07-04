---
layout: snappy-dev-default
title: Key Concepts
permalink: /snappy-dev/key_concepts/
---
# Key Concepts
snapd technology offers a new way to package, distribute, update and run OS components and applications on a Linux system.

This section provides an overview to the key concepts and technologies that enable snapd systems, covering:

* the [core principals of the snapd system](../the_snappy_system), including the snap package, transactional updates and application confinement.
* [Ubuntu Core](../ubuntu_core_desktop), a new minimal server image with the same libraries as today’s Ubuntu designed to be implemented in Canonical's snapd systems.
* four [kinds of snaps](../kinds_of_snaps), three to implement the core OS and device and one type for applications.
* a [store](../store) where snaps are distributed for both testing and final release.
* a system for [securely adding information to snaps and store users](../assertions).
* [interfaces](../interfaces) to enable applications to access OS features or share features with other applications.
* [transational updates](../transactional_updates) that enable snaps to be updated easily and rolled back if needed.
* [garbage collection](../garbage) to ensure old versions of snaps are appropriately removed from devices.

At the end of this section you'll have an understanding of what the snapd system is about and be ready to move onto the next section, which looks at the [architecture of snaps in detail](../architecture_of_snaps).