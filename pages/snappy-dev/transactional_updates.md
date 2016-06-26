---
layout: snappy-dev-default
title: Transactional Updates
permalink: /snappy-dev/transactional_updates/
---
# Transactional Updates
Snappy Ubuntu Core Series 16 employs a transaction update system that relies on a bootloader that is able to load n system images.

## Installation
Each snap -- be it a kernel, OS, gadget or application snap -- is delivered as a read only, squashfs file. When installed it's stored in a directory named with its version number and accompanied by a version number named writable space (and both are symlinked to `current`). In addition, the snap also gets a common multi-version writable space.

## Update (Refresh)
When the snap is updated (by the user running `$ snap refresh <snap name>`) the read-only image of the new version is stored in a new directory named after the new version, a new writable space is created, and the data from the previous version's writable space copied to the new one. Data in the common space isn't altered in any way. The new version's snap and writable area then are both symlinked to `current`. The process is illustrated below:

![The lifecycle of a snap's update](/docs-demo/media/snappy-dev/transactional_updates.png)

For updated kernel, OS, and gadget snaps as well as application snaps run by a daemon, they becomes available the next time the system is booted. Updated application snap commands run the updated version the next time the command is run. 

## Rollback

A strenght of the snappy transactional update system is its ability to roll back if the new version of a snap proves faulty. The process is very simple, the `common` symlink for the snap and its writable data area are simply linked back to the old (previously working) version of the snap.

For application snaps the user does this with ??. While for the Kernel and OS snaps, if these fail to start correctly, the snappy system will automatically rollback these snaps.