---
layout: snappy-dev-default
title: Manage_device_channels
permalink: /snappy-dev/manage_device_channels/
---
# Channels #

(from https://developer.ubuntu.com/en/snappy/guides/channels/)

Users of Ubuntu Core want to be up to date and have a reliable system. To allow maximum flexibility we offer options where you can track just what you need by picking the right:

 - **Release**, which indicates general Ubuntu release is being tracked.
 - **Channel**, which specifies the expectations for the quality of the
   software.

## Ubuntu Core releases ##

Starting from Ubuntu 16, Ubuntu Core will be published as part of the Ubuntu release process.

You have two choices when tracking Ubuntu Core. Either you stay on a particular release, or you pick rolling: rolling is a channel that will automatically roll forward from series 16 to series 17 and beyond. Think of it as the "trunk" of Ubuntu Core. It will never have a stable channel.

When making a decision about releases, consider:

 - **State of enablement**: Do you expect changes to the kernel or plumbing
   layer that will make your device work better? If so, track the newest
   development release, or rolling. This is obviously true as well if
   you plan to participate in enablement.
 - **Support options**: If you want to ship your device to customers,
   consider how long the Ubuntu release in question will be supported.

## Available channels
Channels defined the quality expectations for the release they offer:

 - **edge** - The very latest, very likely to include bugs - useful for
   developers of the platform. 
 - **beta** - Beta quality, includes manual testing by QA. 
 - **candidate** - Release candidate quality.
 - **stable** - Rock solid release quality.

Within each *release* (16 or rolling) a full set of channels (edge, beta, candidate, and stable) will be available, except for rolling/stable given that rolling always moves to the next release. 
## Image promotion ##
Ubuntu snaps (Ubuntu core, gadget snaps and kernel snaps) are generated daily (often multiple images per day) and are thoroughly tested with automated and manual tests to ensure they comply with Ubuntu's QA standard. These daily images are distributed on the edge channel.

![Promotion of images from the edge channel to beta](https://github.com/CanonicalLtd/snappy-docs/blob/master/media/Image_promotion.png)

For these edge images to be release in the beta channel they have to comply with a more strict set of quality criteria, and pass a more stringent set of automated tests. Therefore only a subset of edge releases, those that pass additional test, make it to beta. 
## Choosing a release and channel to track ##
The following table will make it easier to pick a release and channel combination to base your Ubuntu Core system on:

Release | 'edge' channel | 'beta' channel | 'candidate' channel | 'stable' channel
----------| ----   | ----   | ----    | ----
16 | Only suitable for developers tracking the latest development | Beta milestones | Release Candidate milestones | Rock-solid, to be shipped to device customers
rolling | Only suitable for developers tracking the latest development | Beta milestones | Release Candidate milestones | N/A

Some examples:

 - You’ve a device which is working fine, is fully supported in 16 and
   doesn't need any upcoming changes; you track 16/stable.
 - You’re a community member wanting to help test the Release Candidate
   (RC) image during release week. In this case, you should track
   16/candidate.
 - You’re an engineer who participates in development and wants to work
   with a system that has been tested by Ubuntu's continuous integration
   (CI) infrastructure so you would track rolling/beta. If you wanted to
   be adventurous, and take changes before CI approval, you would track
   rolling/edge instead.

## Implementing your release and channel of choice ##
To make use of your chosen channel/release combination you specify them during image installation, and by default, the most recent image available for the device is used. After you've chosen an image channel/release for installation, it will be used to provide Over-The-Air (OTA) upgrades to your device. Generally, once you have the right channel/release you won’t change it. However, you can switch channels at a later point using command line tools.

Your choice of release and channel will be reflected in image URLs and your use of ubuntu-device-flash (e.g. http://cdimage.ubuntu.com/ubuntu-snappy/16/edge/ubuntu-16-snappy-armhf-bbb.img.xz).