---
layout: snappy-dev-default
title: Build Your First Snap
permalink: /snappy-dev/build_apps_first/
---
# Build Your First Snap

Snapcraft uses a single text file to describe the entire build process for a snap: the snapcraft.yaml file. You can see an example in this directory:

    $ cd snapcraft-tour/00-SNAPCRAFT/01-easy-start
    $ ls
    snapcraft.yaml

Notice that `snapcraft.yaml` is the only file in the directory. Snapcraft doesn't need anything else as it will fetch everything it needs to build the snap, using the `snapcraft.yaml` description for the snap. Take a look inside:

    $ more snapcraft.yaml
    name: hello
    version: "2.10"
    summary: GNU Hello, the "hello world" snap
    description: GNU hello prints a friendly greeting.
      This is part of the snapcraft tour at https://snapcraft.io/create/
    confinement: strict

    apps:
      hello:
        command: hello

    parts:
      gnu-hello:
        plugin: autotools
        source: http://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz

The snapcraft tool will interpret this file, fetch and install everything that is needed, build it, and give you a snap.

Start by building this snap, noting that you’ll be prompted for your system password each time you run `snapcraft`:

    $ snapcraft
    [sudo] password for [your user name]:  ***
    Preparing to pull gnu-hello
    Pulling gnu-hello
    Preparing to build gnu-hello
    Building gnu-hello 
    ...
    Snapped hello_2.10_amd64.snap

You'll have seen that Snapcraft fetched the source code, configured, and built it. The snap is now available in your directory, along with new `parts`, `prime`, and `snap` directories.

    $ ls
    hello_2.10_amd64.snap  parts  snap  snapcraft.yaml  prime

As you can see a snap is a single file. The name of the file is based on information in the `snapcraft.yaml` (its name and version) and the architecture you're building on: `<name>_<version>_<arch>.snap`.

Here, the snap was built on an amd64 machine, so the architecture used in the file name reflects that. (The following commands, and exercises later in this section, use globs so you don't need to replace the architecture if yours is different.)

Now, everything you need for the hello app is inside the snap file. You can install it locally:

    $ sudo snap install hello_2.10_*.snap
    hello 2.10 installed

    64.64 MB / 64.64 MB [=============================] 100.00 % 3.97 MB/s 

    Name   Version  Rev     Developer  Notes
    hello  2.10     X1

Congratulations, you've just made and installed your first snap.
