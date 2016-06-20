---
layout: snappy-dev-default
title: 15_to_16_important_changes
permalink: /snappy-dev/15_to_16_important_changes/
---
# Important System Changes
During the development of Series 16 there were several changes to environment in which apps are executed that you may need to be aware of.

## Environment Variables 
When a snap package is installed on to a system, a launcher script is created for each app that it declares in the directory `/snap/bin`. This is a snap specific location on the system `PATH`. This script is responsible for configuring the shell environment that apps will run in. A number of key variables have been re-named since 15.04:

15.04 | Series 16 | Description
---- | ---- | ----
SNAP_APP_PATH | SNAP | Name change - The directory where the snap is mounted
SNAP_APP_DATA_PATH | SNAP_DATA | Name change - A directory to store data or configuration needed whenever the an app from the snap is run. Write access would require root privileges.
SNAP_APP_TMPDIR | removed | 
SNAP_NAME | SNAP_NAME | No change - The package name
SNAP_VERSION | SNAP_VERSION | No change - The package version
SNAP_ORIGIN | removed
SNAP_FULLNAME | removed
SNAP_ARCH | SNAP_ARCH | No change - The target device CPU architecture
SNAP_APP_USER_DATA_PATH | SNAP_USER_DATA | Name change - A directory to store data or configuration specific to the user. Always writeable.
-  | SNAP_REVISION | New
-  | SNAP_LIBRARY_PATH  | New 

The snap `hello-world` provides a number of apps that are useful for experimenting with the environment that applications will run in. The launcher scripts can be examined to confirm the configuration.

` $ sudo snap install hello-world
$ hello-word.env 
XDG_SESSION_ID=1
SHELL=/bin/bash
TERM=vt220
HUSHLOGIN=FALSE
USER=ubuntu
LS_COLORS=
SNAP_LIBRARY_PATH=/var/lib/snapd/lib/gl:
SNAP_USER_DATA=/home/ubuntu/snap/hello-world/25
SNAP_DATA=/var/snap/hello-world/25
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
MAIL=/var/mail/ubuntu
TEMPDIR=/tmp
_=/usr/bin/env
PWD=/home/ubuntu
LANG=C.UTF-8
SNAP_REVISION=25
HOME=/home/ubuntu/snap/hello-world/25
SHLVL=2
SNAP_NAME=hello-world
LOGNAME=ubuntu
SNAP_ARCH=amd64
LESSOPEN=| /usr/bin/lesspipe %s
SNAP_VERSION=6.0
XDG_RUNTIME_DIR=/run/user/1000
SNAP=/snap/hello-world/25
LESSCLOSE=/usr/bin/lesspipe %s %s `

`/snap/bin/hello-world.sh `
`ubuntu@localhost:~$ cat /snap/bin/hello-world.sh`
`#!/bin/sh`
`set -e`
`# snap info`
`export SNAP="/snap/hello-world/25"`
`export SNAP_DATA="/var/snap/hello-world/25"`
`export SNAP_NAME="hello-world"`
`export SNAP_VERSION="6.0"`
`export SNAP_REVISION="25"`
`export SNAP_ARCH="amd64"`
`export SNAP_LIBRARY_PATH="/var/lib/snapd/lib/gl:"`
`export SNAP_USER_DATA="$HOME/snap/hello-world/25"`

`if [ ! -d "$SNAP_USER_DATA" ]; then`
`   mkdir -p "$SNAP_USER_DATA"`
`fi`
`export HOME="$SNAP_USER_DATA"`

`# Snap name is: hello-world`
`# App name is: sh`

`ubuntu-core-launcher snap.hello-world.sh snap.hello-world.sh \ /snap/hello-world/25/bin/sh "$@" `



