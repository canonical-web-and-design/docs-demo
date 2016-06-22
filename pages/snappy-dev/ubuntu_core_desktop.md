---
layout: snappy-dev-default
title: Ubuntu Core and Ubuntu Desktop
permalink: /snappy-dev/ubuntu_core_desktop/
---
# Ubuntu Core and Ubuntu Desktop 

## What is Ubuntu Core?

Snappy Ubuntu Core is a lightweight, transactionally updated OS for devices targeted at the Internet of Things (IoT). It consists of a minimal rootfs and key services such as network. All other user features are added by installing additional snaps into a Snappy Ubuntu Core system or device. In simple terms, it can be though of as the smallest version of Ubuntu needed to support a system.

Practical implementations of Snappy Ubuntu Core consist of:

- Kernel snap
- Gabget snap
- OS snap  

Ubuntu Core is delivered in the OS snap (see [Kinds of Snaps](kinds_of_snaps "Kinds of Snaps") for more details on these and the other types of snaps: application snaps). 

## Difference with Ubuntu Desktop

Snappy Ubuntu Core diverges from the standard model of Server and Desktop Ubuntu distributions, the key differences are summarized in the table below:

Ubuntu Desktop | Ubuntu Core
---- | ----
Can be both a development and target platform. | Acts as a target platform only.
Applications delivered in DEB packages or as snaps. | Applications delivered as snaps.
- | Updated transactionally.
 
## Release cycles

New versions Ubuntu Core will be released every two years, with each release being referred to a series suffixed with the release year, so for example the current release is Series 16 and the next will be Series 18. 
