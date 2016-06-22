---
layout: snappy-dev-default
title: Multiple versions of snaps & garbage collection
permalink: /snappy-dev/garbage/
---
# Multiple versions of snaps & garbage collection

(from https://developer.ubuntu.com/en/snappy/guides/garbage/) 

As a snap package is updated, the old version is kept. This enables Ubuntu Core to rollback to an old, known to be good version if issues are detected in the updated snap. As these old copies take up disk space, to ensure they don’t take up too much disk space while preserving the ability to rollback, garbage collection is performed automatically.

A snap present in a system can be:

 - `installed` (but not active)
 - `active`

When a snap is updated, the snap file for the latest version becomes the active snap file. The content from the previous snap version’s writeable area is copied to a new location for use by the updated snap.

![Garbage collection removes older snap files ](/docs-demo/media/snappy-dev/garbage_collection.png)

Garbage collection then removes and purges any snap files and their writeable areas for the snap versions prior to the one that has just been updated -- meaning that at most two versions of a snap will be present on the system. This saves disk space without compromising the ability to revert your system to a previous known-good state.

Explicitly removing a snap from your system will also remove *and purge* all prior versions.

You can disable garbage collection with the `--no-gc` commandline option, or when removing or purging a part, by specifying the version on which to operate explicitly.

## Example

To illustrate the process take the example of installing and updating `hello-world` through a few versions. If you've version `1.0.1` installed, and do a `snappy update` it downloads version `1.0.2`:

    $ sudo snappy update
    Installing hello-world.canonical (1.0.2)
    Starting download of hello-world.canonical
    30.99 KB / 30.99 KB [======================]
    Done
    Name        Date    Version Developer
    hello-world 1-01-01 1.0.2   canonical
    $ snappy list | grep hello
    hello-world 2015-03-31 1.0.2   canonical
    $ snappy list -v | grep hello
    hello-world  2015-03-31 1.0.1   canonical
    hello-world* 2015-03-31 1.0.2   canonical

so, `1.0.2`, was downloaded and made active, leaving `1.0.1` installed. Doing the upgrade again:

    $ sudo snappy update
    Installing hello-world.canonical (1.0.3)
    Starting download of hello-world.canonical
    30.99 KB / 30.99 KB [======================]
    Done
    Name        Date    Version Developer
    hello-world 1-01-01 1.0.3   canonical
    $ snappy list -v | grep hello
    hello-world  2015-03-31 1.0.2   canonical
    hello-world* 2015-03-31 1.0.3   canonical

and `1.0.1` is gone.