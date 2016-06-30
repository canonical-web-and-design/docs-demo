---
layout: snappy-dev-default
title: The Snappy System
permalink: /snappy-dev/the_snappy_system/
---

# The Snapd System

In traditional Linux distributions, software is made available in packages:

- that rely on the availability of services in the OS or other software.
- whose data isn't confined, so can be accessed by other software.
- that can be detrimentally effected by a system or software upgrade.
- that are complex to uninstall or downgrade.
- rely on a small number of approved 'packagers' to add them to the distro repositories.

Creating and distributing software can therefore be a time consuming process and the end result doesn't offer the user a high degree of security and manageability. 

The Snapd System aims to fix these challenges by offering:

- System components and applications as self contained (except for the most basic OS features, such as network access), read only images, called snaps.
- A confinement and security model that:
 - Offers snaps a secure storage area isolated from other snaps.
 - Enables snaps to make features available to other snaps and for other snaps to consume those features over defined interfaces.
 - A store where developers can easily make their software directly available to users and from which devices can automatically pull updates on a daily basis.
- A simple transactional update system where snaps can be easily uninstalled (by deleting the snap package) or rolled back (by reverting to the previous snap image and private storage area). 

On a Snapd System these features are implemented by:

- **snapd**, a management environment that handles installing and updating snaps using the transactional system, as well as [garbage collection](../garbage) of old versions of snaps.
- **snapd-confine**, an execution environment for the applications and services delivered in snap packages.

![Snaps are self contained, confined applications that can make use of features in other snaps using Interfaces.]( /docs-demo/media/snappy-dev/snap_in_snappy_system.png "Snaps in the Snapd System")

The Snapd System simplifies the development of devices and their software because, with the exception of a [limited number of OS features](../ubuntu_core_desktop.md "Interfaces in Ubuntu core"), you're in control of all the components in your application. You simply add everything needed to the snap package. You then make the snap available using [the store](store "the store"), or, if you are the device creator, create your own store. 