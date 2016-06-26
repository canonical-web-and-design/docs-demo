---
layout: snappy-dev-default
title: List of Interfaces
permalink: /snappy-dev/interfaces_list/
---
# List of Interfaces

Interface name | Purpose | Usage | Auto-Connect
----|----|----|----
`cups-control` | Can access cups control socket. This is restricted because it provides privileged access to configure printing. | reserved | no
`firewall-control` | Can configure firewall. This is restricted because it gives privileged access to networking and should only be used with trusted apps. | reserved | no
`gsettings` | Can access global gsettings of the user's session. This is restricted because it gives privileged access to sensitive information stored in gsettings and allows adjusting settings of other applications. | reserved | yes
`home` | Can access non-hidden files in user's `$HOME` to read/write/lock. This is restricted because it gives file access to the user's `$HOME`. | reserved | yes
`locale-control` | Can manage locales directly, separate from `log-observe` | Can read system logs and set kernel log rate-limiting. | reserved | no 
`config ubuntu-core`. | reserved | no
`mount-observe` | Can query system mount information. This is restricted because it gives privileged read access to mount arguments and should only be used with trusted apps. | reserved | no
`network` | Can access the network as a client. | common | yes
`network-bind` | Can access the network as a server. | common | yes
`network-control` |Can configure networking. This is restricted because it gives wide, privileged access to networking and should only be used with trusted apps. | reserved | no
`network-observe` | Can query network status information. This is restricted because it gives privileged read-only access to networking information and should only be used with trusted apps. | reserved | no
`opengl` | Can access the opengl hardware. | reserved | yes
`pulseaudio` | Can access the PulseAudio sound server. Allows for sound playback in games and media application. It doesn't allow recording. | common | yes
`snapd-control` | Can manage snaps using snapd. | reserved | no
`system-observe` |Can query system status information. This is restricted because it gives privileged read access to all processes on the system and should only be used with trusted apps. | reserved | no
`timeserver-control` | Can manage timeservers directly, separate from `config ubuntu-core`. | reserved | no
`unity7` | Can access Unity7. Restricted because Unity 7 runs on X and requires access to various DBus services and this environment does not prevent eavesdropping or apps interfering with one another. | reserved | yes
`x11` | Can access the X server. Restricted because X does not prevent eavesdropping or apps interfering with one another. | reserved | yes
