---
layout: snappy-dev-default
title: Build Apps
permalink: /snappy-dev/build_apps/
---
# Build Apps

This section provides details on how to use Snapcraft to create application snaps, as well as covering the common and advanced features of snap development. The content includes:

- [Build your first snap](../build_apps_first)
- [Migrate from 15.04 to Series 16](../15_to_16_introduction")
- [Use parts in your snap](../build_apps_parts)
- [Apps as a service](../build_apps_services)
- [Debug your snap](../build_apps_debugging)
- [Publish your snap](../build_apps_publish)
- [Build your own plugin](../build_apps_plugin)

## Snapcraft tour
A number of exercises are included in this section that use the examples included in the Snapcraft tour. To use these examples, you'll need to have Snapcraft 2.11 or later installed. If you've already installed Snapcraft you can check the version as follows:

    $ snapcraft --version
    2.11

If you haven't installed Snapcraft, it's available on Ubuntu 16.04 LTS:

    $ sudo apt install snapcraft

It will also install and run on any Linux distribution with an up-to-date version of [LXD, the container hypervisor](http://www.ubuntu.com/cloud/lxd).

The tour is used on [snapcraft.io](http://snapcraft.io/create/) to walk you through the making of snaps. Here the examples are used to provide practical illustrations of the snap building processes and principals discussed.

The tour includes all the example source code and files in a series of subdirectories, which you load using the Snapcraft tool:

    $ snapcraft tour
    Snapcraft tour initialized in ./snapcraft-tour/
    Instructions are in the README, or https://snapcraft.io/create/#begin

Each stage of the tour is in a separate subdirectory, with number prefixes showing the sequence. In each directory you'll find a README with instructions relevant to that directory.

Unless you specify a different directory name, the tour will be created in a new `snapcraft-tour` subdirectory in your current working directory. The directory structure will look like this:

    $ ls snapcraft-tour/**
    snapcraft-tour/README.md

    snapcraft-tour/00-SNAPCRAFT:
    01-easy-start  02-parts

    snapcraft-tour/10-SNAPS:
    01-service  02-service-confined

    snapcraft-tour/20-PARTS-PLUGINS:
    01-reusable-part

If you wish to follow the tour, you can cd into each directory and work through the README, or follow the tour on [snapcraft.io](http://snapcraft.io/create/).

