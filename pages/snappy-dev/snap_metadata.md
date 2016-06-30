---
layout: snappy-dev-default
title: Snap_metadata
permalink: /snappy-dev/snap_metadata/
---
Title| Snap Metadata
# Snap Metadata
Snaps are defined by two sets of metadata specified in YAML files:

- snapcraft.yaml, which defines the snap to be built, usually with snapcraft. This file is placed in the root of the directory in which the snap is to be built (for more information see [??](../placeholder)).
- snap.yaml, which defines the content of the built snap and is placed in the root of the compressed snap file.

The content of the two YAML files is similar, however snapcraft.yaml includes a definition of the parts included in a snap (which the snap.yaml is missing) and the snap.yaml contains ??

## Purpose of snap.yaml

This file describes the snap package and is essential for defining the content and usable features of the snap. 

## Location of snap.yaml
Within a snap package the `snap.yaml` file is located in the `meta/` directory.

## Keys used in the snap.yaml 

Key | Required | Description 
:---- | ---- | ---- 
<code>name</code> | Yes | The name of the snap. The name may use any combination of lower case letters and numbers plus the '-' character but must start with a letter.
<code>version</code> | Yes | The version of the snap. The version can be defined with any combination of upper and lower case letters, number and the '.', '+', '~', and '-' characters.
<code>summary</code> | No | A short summary of the snap.
<code>description</code> | No | A long description of the snap.
<code>license-agreement</code> | No | Set to `explicit` if the user needs to accept the content of the `meta/license.txt` file before the snap can be installed.
<code>license-version</code> | No | A string defining the version of the licence text. When its value changes and `license-agreement` is `explicit` it causes the user to be prompted to accept the content of `meta/license.txt` again.
<code>type</code> | No |  The type of the snap, can be:  `app`, the default if `type` is omitted or empty; or `gadget`, a special snap that Gadgets can use to customize snappy for their hardware.
<code>architectures</code> | No | A YAML list of supported architectures,  defaults to  `["all"]` if omitted or empty.
<code>apps</code> | No | The map of apps (binaries and services) that a snap provides.
<code>&nbsp;&nbsp;&nbsp;&lt;app name></code> | Yes | The name of the app or service.
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;command</code> | Yes |The command to start the application or service.
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;daemon</code>| Yes | The type of daemon that will run the device: `simple`, `forking`, `oneshot`, or `dbus`
    * `stop-command`: (Optional) The command to stop the service.
    * `stop-timeout`: (Optional) The time in seconds to wait for the service to stop
    * `restart-condition`: (Optional) Specifies the restart
      condition. Can be one of `on-failure` (default), `never`, `on-success`,
      `on-abnormal`, `on-abort`,  and `always`. See `systemd.service(5)`
      (search for `Restart=`) for details.
    * `post-stop-command`: (Optional) A command that runs after the service has stopped.
    * `slots`: A map of interfaces.
<code>&nbsp;&nbsp;&nbsp;ports</code>| No | Defines which ports the service will work.
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;internal</code> | | The ports the service will to connect to.
<code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tagname</code> | | A free form name.
    * `ports`: (Optional) Defines which ports the service will work.
        * `internal`: The ports the service will to connect to.
            * `tagname`: A free form name.
                * `port`: (Optional) Number/protocol, for example `80/tcp`.
                * `negotiable`: (Optional) `Y` if the app can use a different port.
        * `external`: The ports the service offers to the world.
            * `tagname`: A free form name, some names have meaning like "ui".
                * `port`: (Optional) Number/protocol, for example `80/tcp`.
                * `negotiable`: (Optional) `Y` if the app can use a different port.
    * `socket`: (Optional) Set to `true` if the service is socket activated. Must be specified with `listen-stream`.
    * `listen-stream`: (Optional) The full path of the stream socket or an
                abstract socket. When specifying an absolute path, it should
                normally be in one of the app-specific writable directories.
                When specifying an abstract socket, it must start with `@` and
                typically be followed by either the snap package name or the
                snap package name followed by `\_` and any other characters, for example  `@name` or `@name\_something`.
* `slots`: A map of interfaces.