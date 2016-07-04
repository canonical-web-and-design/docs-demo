---
layout: snappy-dev-default
title: Ubuntu Core and Ubuntu Desktop
permalink: /snappy-dev/ubuntu_core_desktop/
---
# Ubuntu Core and Ubuntu Desktop 

## What is Ubuntu Core?

Ubuntu Core is a lightweight, transactionally updated OS for devices targeted at the Internet of Things (IoT) space. It consists of a minimal `rootfs` and key services such as network. All other user features are added by installing additional snaps into a snapd system or device. In simple terms, it can be thought of as the smallest version of Ubuntu needed to support a system.

Practical implementations of Ubuntu Core in a snapd system consist of:

- Kernel snap
- Gadget snap
- OS snap  

Ubuntu Core is delivered in the OS snap (see [Kinds of Snaps](../kinds_of_snaps "Kinds of Snaps") for more details on these and the other types of snaps). 

## Differences to Ubuntu Desktop

Ubuntu Core diverges from the standard model of server and desktop Ubuntu distributions, the key differences are summarized in the table below:

Ubuntu Desktop | Ubuntu Core
:---- | :----
The base rootfs and kernel are delivered as a monolithic package that doesn't enable transactional updates. | OS and kernel delivered as separate snaps, offering transactional updates.
Can be both a development and target platform. | Acts as a target platform only.
Applications delivered in DEB packages or as snaps. | Applications delivered as snaps.
The rootfs file system can be written to and therefore could be tampered with. | The rootfs file system is read only, preventing tampering.
 
## Release cycles

New versions of Ubuntu Core will be released every two years, with each release being referred to as a "series" suffixed with the release year. For example, the current release is Series 16 and the next will be Series 18. 
