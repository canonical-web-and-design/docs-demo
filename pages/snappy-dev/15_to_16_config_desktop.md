---
layout: snappy-dev-default
title: 15_to_16_config_desktop
permalink: /snappy-dev/15_to_16_config_desktop/
---
# Configuring Ubuntu Desktop for snap development

This sections describes how to configure an Ubuntu 16.04 Desktop install for snapcraft package development. 

1. Begin by installing the snap service, command line tools, and snapcraft. These tools are now available in the standard Ubuntu repositories so no PPAs need be installed.
`   
$ sudo apt update
    $ sudo apt install snapd snapcraft snapcraft-examples
    …
    Setting up snapd (2.0.2) ...
    Setting up snapcraft (2.8.4) ...`

2. The command line tools should now be able to search the public store and install snaps. Note the change of program name from “snappy” to “snap”.
`
    $ snap find hello-world
    Name         Version  Summary
    hello-world  6.0      Hello world example
    $ sudo snap install hello-world
    [sudo] password for user: 
    [\] Make snap "hello-world" available to the system
    $ hello-world.echo 
    Hello World!`

3. The snapcraft package creation tool should also now be available. A selection of example snap specifications are provided in the associated snapcraft-examples package and cover a variety of packaging scenarios. Copying these to a writable location should allow the developer to test them.
`    $ snapcraft --version    `
`    2.8.4`
`    $ tree -dL 1 /usr/share/doc/snapcraft-examples/examples `
`    /usr/share/doc/snapcraft-examples/examples  `
`    ├── 96boards-kernel `
`    ├── busybox `
`    ├── downloader-with-wiki-parts `
`    ├── git`
`    ├── godd`
`    ├── gopaste`
`    ├── java-hello-world`
`    ├── libpipeline`
`    ├── mosquitto`
`    ├── opencv`
`    ├── py2-project`
`    ├── py3-project`
`    ├── ros`
`    ├── shout`
`    ├── tomcat-maven-webapp`
`    ├── webcam-webui`
`    └── webchat`
` `
`    17 directories`
`    $ cp -r /usr/share/doc/snapcraft-examples/examples/webcam-webui /tmp`
`    $ cd /tmp/webcam-webui/`
`    $ snapcraft`
`    …`
`    Snapped webcam-webui_1_amd64.snap`

