---
layout: lxd-default
title: Api_extensions
permalink: /lxd/api_extensions/
---
# API extensions

The changes below were introduced to the LXD API after the 1.0 API was finalized.

They are all backward compatible and can be detected by client tools by  
looking at the api\_extensions field in GET /1.0/.


## storage\_zfs\_remove\_snapshots
A storage.zfs\_remove\_snapshots daemon configuration key was introduced.

It's a boolean that defaults to false and that when set to true instructs LXD  
to remove any needed snapshot when attempting to restore another.

This is needed as ZFS will only let you restore the latest snapshot.

## container\_host\_shutdown\_timeout
A boot.host\_shutdown\_timeout container configuration key was introduced.

It's an integer which indicates how long LXD should wait for the container  
to stop before killing it.

Its value is only used on clean LXD daemon shutdown. It defaults to 30s.

## container\_syscall\_filtering
A number of new syscalls related container configuration keys were introduced.

 * security.syscalls.blacklist\_default
 * security.syscalls.blacklist\_compat
 * security.syscalls.blacklist
 * security.syscalls.whitelist

See configuration for how to use them.

## auth\_pki
This indicates support for PKI authentication mode.

In this mode, the client and server both must use certificates issued by the same PKI.

See lxd-ssl-authentication for details.

## container\_last\_used\_at
A last\_used\_at field was added to the /1.0/containers/\<name\> GET endpoint.

It is a timestamp of the last time the container was started.

If a container has been created but not started yet, last\_used\_at field
will be 1970-01-01T00:00:00Z