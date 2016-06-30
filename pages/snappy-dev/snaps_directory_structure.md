---
layout: snappy-dev-default
title: Snaps Directory Structure	
permalink: /snappy-dev/snaps_directory_structure/
---
# Snaps Directory Structure

This section describes the directories found within a snap and details their content. If you're building your snaps with snapcraft, after running a build the directory structure can be seen in the `prime/` directory. 

Directory | Purpose | Content
:---- | ---- | ----
`root` | | `*.wrapper` files
`bin` | Contains all the components of the software being delivered in the snap
`meta` | Contains details that describe the snap | [`snap.yaml`](snap_metadata.txt), licence.txt
`meta/hooks` | See `config.md` for details.
`share` |
`gui` | Contains GUI releated files for the snap.

## Interfaces

Interfaces allow snaps to communicate or share resources according to the protocol established by the interface and play an important part in security policy configuration. See `interfaces.md` and `security.md` for details.

##  Name spaces

## Environment variables

## Wrapper script
	
## license.txt

A license text that the user must accept before the snap can be installed.


##	Desktop snaps
## gui/ directory

The gui directory contains GUI releated files for the snap.

### dekstop files

The `gui/` directory may contain .desktop files for the snap. Those desktop files may contain all valid desktop entries from the xdg Desktop Entry Specification version 1.1 with some exceptions listed below. If there is a line with an unknown key or an unofficial key that line is silently removed from the desktop file on install.

Only `Exec=` lines that start with `Exec=$snap.$app` are valid, but arguments may be passed. E.g. for a snap like|

    name| http
    version| 1.0
    apps|
     GET|
      command| myhttpdownlaoder.get-stuff</div><div class="eight-col">

With a desktop file|

    [Desktop Entry]
    Name=My downloader
    Exec=http.GET %U

The `Exec=` line is valid because it starts with `Exec=http.GET` (the snap is called "http" and the app is called "GET").

### Unsupported desktop keys

The `DBusActivatable`, `TryExec` and `Implements` keys are currently not supported and will be silently removed from the desktop file on install.


# Examples

See [https|//github.com/snapcore/snapd-testdata](https|//github.com/snapcore/snapd-testdata) for up-to-date examples.