---
layout: snappy-dev-default
title: Installing Snaps
permalink: /snappy-dev/installing_snaps/
---
# Installing Snaps

Users will normally install snaps from a store, logging in first. They can then search for snaps or install snaps by name. Stores can provide snaps in various [channels](../manage_device_channels) and snaps that need to be run in developer mode. Details on installing and using these snaps are provided here. 

**Note**: At the time of writing the only store available is Ubuntu Store and the snap login instruction take you to that store. In the future other stores should be available.

## Log in to a snap store

Snap stores holds a public collection of snaps for delivery to clouds, devices, and private infrastructure. Users [sign-in](https://login.ubuntu.com/+login) to a store (currently Ubuntu Store only) from a device as follows:

    $ snap login me@myself.com
    Password: *********
    2-factor: ******
    Welcome!


## Finding Snaps

A store can contain both public and private snaps.

Anybody can publish a snap, but store searches will only find snaps that have been reviewed and judged to be of good quality, and which can be installed securely. These are the ‘promoted’ snaps.

Searches look for matches in the snap name or description:

    $ snap find hello
    Name           Version  Developer  Notes  Summary
    hello          2.10     canonical  -      GNU Hello, the "hello world" snap
    hello-huge     1.0      noise      -      A really big snap
    hello-world    6.1      canonical  -      Hello world example

## Installing the snap

Users can install any public or their own private snaps using the snap name. Here is an example of installing GNU Hello from the Free Software Foundation:

    $ snap install hello

## Running the snap

Each snap might include multiple related commands, with a default command that has the same name as the snap itself. Additional commands are prefixed with the snap name:

    $ hello
    Hello, world!
    $ hello.universe
    Hello, universe!

Snaps can also install services that run in the background, such as web servers or content management systems. Those will start automatically when the snap is installed.

## Viewing installed snaps details

To see a list of snaps installed on a system use `snap list`. The list also provides information on the software version, revision number, developer, and any extra notes provided with the snap (such as whether the snap is in developer mode or not).

    $ snap list
    Name           Version               Rev  Developer  Notes
    hello          2.10                  26   canonical  -
    ubuntu-core    16.04+20160419.20-55  109  canonical  -
    webdm          0.17                  21   canonical  -

## Always fresh -- update fast and reliably

Snaps are updated automatically in the background to the the latest version, every day. This can also be done manually using `snap refresh` for either all installed snaps or by specifying particular snaps to refresh.

## Release channels -- stable, candidate, beta and edge

Snaps can be published as stable, release candidate, beta, and edge versions, at the same time. This enables you to engage with users who are willing to test changes, and it help users to decide how close to the leading edge of development they want to be.

By default, snaps are installed from the stable channel. Versions of snaps from other channels need to be explicitly selected:

    $ snap install hello --channel-beta

And a snap can be refreshed from a different channel to the one it was originally installed from:

    $ snap refresh hello --channel=beta
    Name    Version   Rev   Developer   Notes
    hello   2.10.1    29    canonical   -
    hello  (beta) installed

The beta version is then run in exactly the same way as the stable (or any other) version:

    $ hello
    Hello, snap padawan!

## Developer mode

When you're developing a snap, you'll want to let it run without the strict security confinement that is expected of stable, published snaps. This is done by specifying `--devmode` on installation, to give permission for the snap to be run without confinement.

You can publish snaps that require `--devmode` to work, but they can only be published to the beta or edge channels, not the stable or candidate channels. User can then install those beta or edge versions using `--devmode` as well. Because of the risk that installing an unconfined app creates, the user is asked to confirm the installation:

    $ snap install flubber --channel=beta
    Error: this version of foo requires devmode.
    $ snap install flubber --channel=beta --devmode
    WARNING: snaps installed in devmode are not confined. You are trusting
    all the private data on this system to the developer "frankie".

    Do you still want to install ‘flubber’? [y/N] N