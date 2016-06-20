---
layout: snappy-dev-default
title: Kinds_of_snaps
permalink: /snappy-dev/kinds_of_snaps/
---
#The kinds of snaps
There are four kinds of snaps used in a snappy system:

 - Kernel
 - Gadget
 - OS
 - Application

These snaps form the architecture of a snappy system as shown below.

![snap architecture](https://github.com/CanonicalLtd/snappy-docs/blob/master/media/snap_architecture.png)

##Kernel snaps

The kernel makes up the core of all Linux systems, and it's the same with a snappy system.

The kernel snap contains a system’s hardware abstraction layer (HAL). This layer  consist of the kernel, drivers, firmware, and additional libraries such as OpenGL, OpenCL, and alike. In addition the sandboxing and confinement features are provided through the kernel and their effectiveness depend on the security maintenance level of that kernel.

Canonical publishes and maintains kernel snaps, offering reliability, trust, and security. 

You can also create custom kernel snaps for devices. The snap should be based on a Linux kernel with reasonable baseline versioning. However, aligned with the Ubuntu Core LTS default kernel version (currently 3.18) is recommended. This will ensure that devices built using custom kernel snaps benefit from shared information about the kernel, simplifying support and improving development timelines.

##Gadget snaps

Gadget snaps provide a way to define the specific features of a device. They may include definitions of:

- the mechanisms for device initialisation, such as key generation and identity certification.
- processes for the lifecycle of the device, such as factory resets.
- the store the device can access to obtain additional or updated snaps.
- the permission rules (assertions) that define which snaps can be loaded on the device (see [Assertions](assertions "Assertions") for more details).
- which channel the device will load from by default. For example, a device may be made available for beta testing, so should pull snaps from the beta channel (see [Channels](manage_device_channels "Channels") for more details).
- details of the device hardware (for example that the device has a camera) and the interfaces (see [Interfaces](interfaces "Interfaces")) available to access that hardware.

Canonical publishes some reference gadget snaps as well as gadget snaps for core Canonical models such as official Ubuntu Core VMs on various certified public clouds, as well as general purpose computing images for popular physical devices such as 64-bit x86 PCs and Raspberry Pi2.

##OS snaps

The OS snap is a repacked `rootfs` that contains `snapd`, just 'enough' to boot and power the system. Generally there will also be basic features such as network services, libc, and others. OS snaps will be architecture specific, but hardware platform agnostic. As such an OS snap should be able to run with any kernel that supports the minimum feature set required by the OS.

In every Canonical snappy system the OS snap contains Ubuntu Core (for more details see [Ubuntu Core and Ubuntu Desktop](ubuntu_core_desktop "Ubuntu Core and Ubuntu Desktop").

Canonical is the publisher of the Ubuntu Core OS snap, and it's available for x86 and ARM devices in both 32-bit and 64-bit forms. All devices of the same architecture running the same version of the OS use the same snap. The OS is thus exactly the same for every class of device, whether specialised or general, and developers who target software to a particular snap can be confident it will have access to the same software on any snappy device.

##Application snaps

Application snaps add everything else to a snappy system, they are what makes the system useful. They are normally created by the device developer or third-party developers offering additional features to the device.

An application snap can be run either from a command (that would normally be executed directly or indirectly by the device user) or by a daemon that executes at boot (so effectively offer a service within the device.) An application snap may also provide multiple commands and to avoid namespace conflicts commands are prefixed with the snap’s name, for example the following commands run a normal and debug version of a hello world snap:

- `$ my_hello_world.run`
- `$ my_hello_world.debug`

Application snaps can also provide [Interfaces](interfaces "Interfaces") that expose features to other snaps.

You can create application snaps manually or use the Snapcraft tool. You can find a guide to getting started with Snapcraft on [snapcraft.io](http://snapcraft.io/create/ "snapcraft.io").
