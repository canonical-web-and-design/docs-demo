---
layout: snappy-dev-default
title: Transactional Updates
permalink: /snappy-dev/transactional_updates/
---
# Transactional Updates
Snapd systems employ a method of transactional update that is available for all snaps: application, gadget, OS, and kernel.


## Installation
Each snap -- be it a kernel, OS, gadget, or application snap -- is delivered as a read only, squashfs file. When installed it's stored in a directory named with its revision number (`/var/lib/snapd/snaps/<snap>_<rev>.snap`) and accompanied by revision numbered writable spaces (which are all symlinked to `current`, for example `snap/<name>/current`). In addition, the snap also gets a common multi-revision writable space.

## Update (Refresh)
When the snap is updated (by the user running `$ snap refresh <snap name>`) a new set of directories are created labeled with the snap's revision number (which is incremented each time a snap is added to the store). The read-only image of the new version is stored in the new directory, new writable spaces are created, and the data from the previous version's writable spaces copied to the new ones. Data in the common space isn't altered in any way. The new version's snap and writable areas then are both symlinked to `current`. The process is illustrated below:

![The lifecycle of a snap's update](/docs-demo/media/snappy-dev/transactional_update.png)

Updated kernel, OS, and gadget snaps become available the next time the system is booted. 

For updated application snaps, the new versions become available:

- for user executed applications, the next time the command is run.
- for daemon executed services, immediately, as the daemon is restarted during refresh. 

## Rollback

A strength of the snappy transactional update system is its ability to roll back if the new version of a snap proves faulty. The process is very simple, the `current` symlink for the snap and its writable data area are simply linked back to the old (previously working) version of the snap.

For application snaps the user does this with `snap rollback <snap>`. As with updates, a rolled back service snap becomes available immediately (its daemon is restarted when the rollback completed) while a rolled back app is available when its commend is run. 

For the gadget, kernel, and OS snaps, if these fail to start correctly, the snappy system will automatically rollback these snaps the next time the device is booted.