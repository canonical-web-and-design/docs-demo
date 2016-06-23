---
layout: snappy-dev-default
title: Transitioning Snaps from 15.04 to Series 16
permalink: /snappy-dev/15_to_16_introduction/
---
# Transitioning Snaps from 15.04 to Series 16
During the Ubuntu 16.04 release cycle snappy Ubuntu Core has undergone significant refinement to ensure the following core features are delivered and stable such that they can be supported for the long term:

 - high levels of robustness
 - transactional updates and rollback of system components
 - strong application isolation for security and data protection

This process culminated in the release, tagged 2.0, of the snappy framework. This release produced not only an updated toolset, but also formalized the terminology to describe the features this provides.

The following sections outline some key terms that the author of a snap package should be familiar with when working with snappy Ubuntu Core.

## Series
In contrast to classic Ubuntu releases that happen twice each calendar year, the expectation is that  snappy Ubuntu Core will make one release per year that will be supported for a period of time and will receive only conservative changes. These versions are to be known as “series”. The numbering will be simplified to indicate just the year of release, that is 16, 18 etc. For clarity the version released this year will referred to as Ubuntu Core Series 16.

## The system in snaps (all-snaps)
Beginning in Series 16, all software beyond the bootloader is distributed in the form of snap packages. This change, along with the introduction of [Interfaces](#interfaces "Interfaces"), which removes the need for “framework” snaps, means the valid snap types are now:

 - App
 - Kernel
 - OS
 - Gadget

The physical snap packages themselves are now compressed filesystem (squashfs) images that are mounted when the snap is activated. As such they remain read-only throughout their lifetime on the the device and consume less storage. For comparison, snaps on 15.04 based systems were compressed archives that were unpacked at install time and then could be edited by the root user. 

## Snaps for classic Ubuntu
The Ubuntu 16.04 release brought support for the snap packaging format to “classic” Ubuntu systems including the Desktop and Server, alongside traditional deb-based packages. This provides a new channel for vendors to deploy their software quickly to Ubuntu desktops whilst gaining all the benefits of application isolation.

This also provides a convenient prototyping environment to snap authors targeting other platforms. It's now possible to edit the snapcraft package definition, build the snap, and install it all in the desktop environment before moving to testing on the target device. The following chapter describes how to configure an Ubuntu Desktop install for this purpose.

## Interfaces
Interfaces are a new mechanism of the Snappy 2.0 framework that describe the terms under which apps can reach outside their sandboxed environment to: communicate with other snaps, share particular system resources, or access particular hardware. 

An Interface definition is the specification for the endpoints of the interactions, called plugs and slots, and the protocol used to communicate between them. Snappy mediates these interactions such that the state of the system is clearly observable to the administrator and connections can be made or removed.