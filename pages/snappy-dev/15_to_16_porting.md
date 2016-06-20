---
layout: snappy-dev-default
title: 15_to_16_porting
permalink: /snappy-dev/15_to_16_porting/
---
# Porting 15.04 snaps to Series 16
The snapcraft tool has undergone significant development this cycle and version 2.x has been released specifically to produce snaps targeting Series 16 devices.

This chapter describes the changes that need to take place to take a Snapcraft configuration created using version 1.x and targeting 15.04 snappy systems, to version 2.x for Series 16.

##The Snapcraft YAML File
The Snapcraft YAML file can be considered as containing three functional sections:

 - Packaging Metadata
 - Parts
 - Apps

The majority of the package development work goes into defining the `parts` section as this defines the majority of the payload, how it's built and the source it's pulled from; the YAML schema here has changed relatively little. There are more alterations to the other two sections, however these should only require a small amount of time to update. 
###Packaging Metadata
The metadata has removed the requirement to specify the vendor as information related to the owner of the snap is handled in the store. Fixed assets like icon files, licence files and desktop files do not need to declared in the YAML, but must be placed in specific locations under a top-level “setup” directory to be included. Here is a comparison of the packaging metadata section of the webcam-webui example:

<table>
<tr>
<th>Snapcraft 1.x</th>
<th>Snapcraft 2.x</th>
</tr>
<tr>
<td align="left"><p><code>name: webcam-webui</code></p>
<p><code>version: 1</code></p>
<p style="color:red;"><code>vendor: Vendor &ltemail@example.com&gt</code></p>
<p><code>summary: Webcam web UI</code></p>
<p><code>description: Exposes your webcam ...</code></p>
<p style="color:red;"><code>icon: icon.png</code></p></td>

<td align="left"><code>name: webcam-webui<br />
summary: Webcam web UI<br />
description: Exposes your webcam over a web UI
</code></td>
</tr>
</table>

The icon file to represent the snap, in the store for example,  exists in the setup directory like this:
```
user@ubuntu:~/webcam-webui$ tree
.
├── setup
│   └── gui
│       └── icon.png
├── snapcraft.yaml
└── webcam-webui
```

###Apps
Series 16 reaffirmed the concept of snap packages shipping “apps” that are run on the device. The Snapcraft schema was updated to match this terminology meaning the keys “binaries” and “services” are now handled by the key “apps”.

Programs to be launched by the user where previously declared as binaries. They now are defined as apps as in this example:

<table>
<tr>
<th>Snapcraft 1.x</th>
<th>Snapcraft 2.x</th>
</tr>
<tr>
<td align="left">
<code>binaries:</code><br />
<code>&nbsp;&nbsp;ls:</code><br />
<code>&nbsp;&nbsp;&nbsp;&nbsp;exec: ls</code>
</td>
<td align="left">
<code>apps:<br />
&nbsp;&nbsp;ls:<br />
&nbsp;&nbsp;&nbsp;&nbsp;command: ls<br />
&nbsp;&nbsp;touch:<br />
&nbsp;&nbsp;&nbsp;&nbsp;command: touch</code>
</td>
</tr>
</table>

Long running services or daemons are also defined as apps, but the daemon key is used to indicate they should be invoked by the system. The key has two possible values: `simple` if the `command` configured is the main process, or `forking` if the configured `command` calls `fork()` as part of its start-up, resulting in a different PID to track.

<table>
<tr>
<th>Snapcraft 1.x</th>
<th>Snapcraft 2.x</th>
</tr>
<tr>
<td align="left"><code>services:<br />
&nbsp;&nbsp;webcam-webui:<br />
&nbsp;&nbsp;&nbsp;&nbsp;description: “Exposes your ..."<br />
&nbsp;&nbsp;&nbsp;&nbsp;start: bin/webcam-webui<br /></code></td>
<td align="left"><code>apps:<br />
&nbsp;&nbsp;webcam-webui:<br />
&nbsp;&nbsp;&nbsp;&nbsp;command: bin/webcam-webui<br />
&nbsp;&nbsp;&nbsp;&nbsp;daemon: simple<br /></code></td>
</tr>
</table>

The introduction of Interfaces as the mechanism for requesting access to resources beyond the typical parameters of confinement mean that the keys `security-policy` and `security-override` have been removed. These must not be present in any app declarations for Snapcraft 2.x. 

Other notables changes that apply to the definition of daemons are: 

 - `stop` key has been replaced by `stop-command`
 - Addition of key `restart-command` with possible values of `on-success`, `on-failure`, `on-abnormal`, `on-abort`, and `always`.
###Parts
Any `parts` sections of YAML files written for 15.04 using Snapcraft 1.x will continue to work unchanged on Series 16 when built using Snapcraft 2.x. 

##Snapcraft commands
The steps followed during the process of creating a snap were renamed for the 2.x release. The commands available to the snapcraft program were similarly renamed. The actions undertaken at each stage are directly comparable.

<table>
<tr>
<th>Snapcraft 1.x</th>
<th>Snapcraft 2.x</th>
</tr>
<tr>
<td align="center">pull<br />
↓<br />
build<br />
↓<br />
stage<br />
↓<br />
snap<br />
↓<br />
assemble<br /></td>
<td align="center">pull<br />
↓<br />
build<br />
↓<br />
stage<br />
↓<br />
strip<br />
↓<br />
snap<br /></td>
</tr>
</table>

Once the YAML has been modified to take account of the changes described above the snap package can be built using Snapcraft. Each stage can be run one-by-one by passing the name of the stage to the Snapcraft program or the complete process initiated by passing no argument.

```
webcam-webui$ snapcraft
Preparing to pull glue 
Pulling glue 
Preparing to pull cam 
…
Stripping cam 
Snapping webcam-webui_1_amd64.snap
Parallel mksquashfs: Using 4 processors
Creating 4.0 filesystem on webcam-webui_1_amd64.snap, block size 131072.
[==============================================================================================================================================================================================================================================================================================================|] 124/124 100%

`Exportable Squashfs 4.0 filesystem, xz compressed, data block size 131072
	compressed data, compressed metadata, compressed fragments, no xattrs
	duplicates are removed
Filesystem size 4252.59 Kbytes (4.15 Mbytes)
	30.27% of uncompressed filesystem size (14047.15 Kbytes)
Inode table size 1078 bytes (1.05 Kbytes)
	47.87% of uncompressed inode table size (2252 bytes)
Directory table size 622 bytes (0.61 Kbytes)
	53.76% of uncompressed directory table size (1157 bytes)
Number of duplicate files found 0
Number of inodes 51
Number of files 21
Number of fragments 3
Number of symbolic links  17
Number of device nodes 0
Number of fifo nodes 0
Number of socket nodes 0
Number of directories 13
Number of ids (unique uids + gids) 1
Number of uids 1
	root (0)
Number of gids 1
	root (0)
Snapped webcam-webui_1_amd64.snap 
```

Once a snap file is produced successfully it can be installed on a system using `devmode`, as described below. Note however, that with no Interface support added the snap isn't yet suitable for submission to the store.

##Using devmode to test on a classic Ubuntu system
As described above, Interfaces control when and how a snap can reach outside its sandboxed environment. Version 2.0 of the snappy framework adds a facility called `devmode`, which enable you to indicate, at snap install time, that the security mechanisms should not enforce confinement and instead just warn of events that would breach it. This is a useful way to analyse what Interfaces will be needed to allow correct operation of the app.

After having built a snap on a classic Ubuntu system, a snap can be installed in `devmode` using the following command:

<code>$ sudo snap install --devmode <<b>package-name</b>>.snap</code>

An app can then be executed in the normal fashion. The security system's audit of confinement events will result in messages being appended to the syslog. Compare the following examples of the hello-world snap attempting to create a file in a restricted directory:

 - without `devmode`  
    
    <code>$ sudo snap install hello-world
    $ hello-world.sh
    Launching a shell inside the default app confinement. Navigate to your
    app-specific directories with:
    
      <code>$ cd $SNAP
      $ cd $SNAP_DATA
      $ cd $SNAP_USER_DATA
    
    <code>bash-4.3$ touch test-file1
    touch: cannot touch 'test-file1': Permission denied

 - with `devmode`

    <code>$ sudo snap install hello-world --devmode
    $ hello-world.sh
    Launching a shell inside the default app confinement. Navigate to your
    app-specific directories with:
    
      <code>$ cd $SNAP
      $ cd $SNAP_DATA
      $ cd $SNAP_USER_DATA
    
    <code>bash-4.3$ touch test-file2
    bash-4.3$ exit
    exit
    $ tail /var/log/syslog | grep audit
    May 11 12:06:19 localhost kernel: [50166.075090] audit: type=1400 audit(1462964779.428:49): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.hello-world.echo" pid=28530 comm="apparmor_parser"
    May 11 12:06:26 localhost kernel: [50173.605851] audit: type=1400 audit(1462964786.960:55): apparmor="ALLOWED" operation="mknod" profile="snap.hello-world.sh" name="/home/ubuntu/test-file2" pid=28553 comm="touch" requested_mask="c" denied_mask="c" fsuid=1000 ouid=1000
    May 11 12:06:26 localhost kernel: [50173.606159] audit: type=1400 audit(1462964786.960:56): apparmor="ALLOWED" operation="open" profile="snap.hello-world.sh" name="/home/ubuntu/test-file2" pid=28553 comm="touch" requested_mask="wc" denied_mask="wc" fsuid=1000 ouid=1000 </code>


##Example Projects
The following links provide some examples of Snapcraft YAML files that have been transitioned from 15.04 to Series 16:

<table>
<tr>
<th>15.04 / Snapcraft 1.x</th>
<th>Series 16 / Snapcraft 2.x</th>
</tr>
<tr>
<td align="left" colspan="2">webcam-webui - Exposes your webcam over a web UI</td>
</tr>
<tr>
<td align="left">https://github.com/ubuntu-core/snapcraft/blob/1.x/examples/webcam-webui/snapcraft.yaml</td>
<td align="left">https://github.com/ubuntu-core/snapcraft/blob/master/examples/webcam-webui/snapcraft.yaml</td>

<tr>
<td align="left" colspan="2">gopaste - Simple pasting tool</td>
</tr>
<tr>
<td align="left">https://github.com/ubuntu-core/snapcraft/blob/1.x/examples/gopaste/snapcraft.yaml </td>
<td align="left">https://github.com/ubuntu-core/snapcraft/blob/master/examples/gopaste/snapcraft.yaml  </td>

<tr>
<td align="left" colspan="2">checkbox-snappy - Tool for running tests on Ubuntu Core devices</td>
</tr>
<tr>
<td align="left">https://git.launchpad.net/~checkbox-dev/plainbox-provider-snappy/+git/packaging/tree/snapcraft.yaml?h=vivid_snapcraft1.x</td>
<td align="left">https://git.launchpad.net/~checkbox-dev/plainbox-provider-snappy/+git/packaging/tree/snapcraft.yaml </td>
</tr>
</table>






 
 

