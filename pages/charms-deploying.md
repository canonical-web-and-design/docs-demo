---
layout: default
title: Deploying services  
permalink: /charms-deploying/
---
TODO: First section spent defining charms. This should all be placed in charms.md and
	linked to from here. As of this writing, that page does not cover local charms.
      This page is too long and should be broken up (or apply the fabled TOC).
      PRIORITY: Review 'channel support'. See https://goo.gl/IKzRsD .
      Add 'centos' and 'windows' stuff to series talk
      See whether it is still possible to download all charms (marco ignored me
        on irc)
      Downloading charms is shabby. See https://git.io/vwNLI . I therefore
        ommitted the "feature" of specifying a download dir
      Review specifying 'default-series' key at model level in conjunction with
        deploying local and non-local charms. I detected flakiness.
      Review whether Juju should go to the store when pointing to a local dir
        with non-existant charm. It did not for me but the old version of this
        doc said it should.


# Deploying services

The fundamental point of Juju is that you can use it to deploy services through
the use of charms (the magic bits of code that make things just work). These
charms can exist in the [Charm Store](https://jujucharms.com/store) or on the
file system (previously downloaded from the store or written locally).

Charms use the concept of *series* analogous as to how Juju does with Ubuntu
series ('trusty', 'xenial', etc). For the most part, this is transparent as
Juju will use the most relevant charm to ensure things "just work". This makes
deploying services with Juju fun and easy.


## Deploying from the charm store

Typically, services are deployed using the online charms. This ensures that
you get the latest version of the charm. To deploy in this way:

```bash
juju deploy mysql
```

This will create a machine and use the latest online MySQL charm (for your
default series) to deploy a MySQL service.

!!! Note: The default series can be configured at a model level (see
[Configuring models](./models-config.html)). In the absence of this setting,
the default is to use the series specified by the charm.

Assuming that the Xenial series charm exists and was used above, an equivalent
command is:

```bash
juju deploy cs:xenial/mysql
```

Where 'cs' denotes the charm store.

!!! Note: A used charm gets cached on the controller's database to minimize
network traffic for subsequent uses.

### Channel support	

The charm store offers charms in different stages of development. Such stages
are called *channels*.

```bash
juju deploy mysql --channel channel_name
```

Such a channel will be used if the charm's revision is:

 1. undefined
 1. defined only for the specified non-stable channel

Each channel will have a "pointer" that redirects to a certain *revision*.

#### Charm upgrades

Because the pointer can fluctuate among revisions it is possible that during a
charm upgrade the channel revision is different than the revision of a
currently deployed charm. The following rules apply:

- If a channel revision is older, downgrade the deployed charm to that revision
- If a channel revision is newer, upgrade the deployed charm to that revision

Below we specify a channel with the `charm-upgrade` command:

```bash
juju charm-upgrade mysql --channel channel_name
```


## Deploying from a local charm

To deploy services using local charms, specify the path to the charm directory.
For example, to deploy vsftpd from above (on Trusty):

```bash
juju deploy ~/charms/vsftpd --series trusty
```

The series does not require stating if the model configuration specifies a
value for key `default-series`. For example:

```bash
juju set-model-config -m mymodel default-series=trusty
```

See [Configuring models](./models-config.html) for details on model level
configuration.

See [Addendum: local charms](#addendum:-local-charms) below for further
explanation of local charms and how they can be managed.


## Deploying with a configuration file

Deployed services usually start with a sane default configuration. However, for
some services it is desirable (and quicker) to configure them at deployment
time. This can be done by creating a YAML format file of configuration values
and using the `--config=` switch:

```bash
juju deploy mysql --config=myconfig.yaml
```

See [Service configuration](./charms-config.html) for more on this.


## Deploying to specific machines and containers

It is possible to specify which machine or container a service is to be
deployed to. One notable reason is to reduce costs when using a public cloud;
services can be consolidated instead of dedicating a machine per service unit.

Below, the `--constraints` option is used to create an LXD controller with
enough memory for other services to run. The `--to` option is used to specify a
machine:

```bash
juju bootstrap --constraints="mem=4G" lxd-controller lxd
juju deploy mysql
juju deploy --to 0 rabbitmq-server
```

Here, MySQL is deployed as the first unit (in the 'default' model) and so ends
up on machine '0'. Then Rabbitmq gets deployed to machine '0' as well.

Services can also be deployed to containers:

```bash
juju deploy mysql --to 24/lxd/3
juju deploy mysql --to lxd:25
```

Above, MySQL is deployed to existing container '3' on machine '24'. Afterwards,
a MySQL service is deployed to a new container on machine '25'.

The above examples show how to deploy to a machine where you know the machine's
identifier. The output to `juju status` will provide this information.

It is also possible to deploy units using placement directives as `--to`
arguments. Placement directives are provider specific. For example:

```bash
juju deploy mysql --to zone=us-east-1a
juju deploy mysql --to host.mass
```

The first example deploys to a specified zone for AWS. The second example
deploys to a named machine in MAAS.

The `add-unit` command also supports the `--to` option, so it's now possible to
specifically target machines when expanding service capacity:

```bash
juju deploy --constraints="mem=4G" openstack-dashboard
juju add-unit --to 1 rabbitmq-server
```

There should now be a second machine running both the openstack-dashboard
service and a second unit of the rabbitmq-server service. The `juju status`
command will show this.

These two features make it much easier to deploy complex services such as
OpenStack which use a large number of charms on a limited number of physical
servers.

As with deploy, the --to option used with `add-unit` also supports placement
directives. A comma separated list of directives can be provided to cater for 
the case where more than one unit is being added.

```bash
juju add-unit rabbitmq-server -n 4 --to zone=us-west-1a,zone=us-east-1b
juju add-unit rabbitmq-server -n 4 --to host1,host2,host3,host4
```

Any extra placement directives are ignored. If not enough placement directives
are supplied, then the remaining units will be assigned as normal to a new, clean
machine.


## Juju retry-provisioning

You can use the `retry-provisioning` command in cases where deploying services,
adding units, or adding machines fails. It allows you to specify machines which
should be retried to resolve errors reported with `juju status`.

For example, after having deployed 100 units and machines, status reports that
machines '3', '27' and '57' could not be provisioned because of a 'rate limit
exceeded' error. You can ask Juju to retry:

```bash
juju retry-provisioning 3 27 5
```


## Considerations

Although we are working to have each service co-locatable without the danger of
conflicting configuration files and network configurations this work is not yet
complete.

While the `add-unit` command supports the `--to` option, you can elect not use
`--to` when doing an "add-unit" to scale out the service on its own node.

```bash
juju add-unit rabbitmq-server
```

This will allow you to save money when you need it by using `--to`, but also
horizontally scale out on dedicated machines when you need to.


## Selecting and enabling networks

Use the `networks` option to specify service-specific network requirements. The
`networks` option takes a comma-delimited list of Juju-specific network names.
Juju will enable the networks on the machines that host service units. This is
different from the network constraint which selects a machine that matches the
networks, but does not configure the machine to use them. For example, this
commands deploys a service to a machine on the "db" and "monitor" networks and
enabled them:

```bash
juju deploy --networks db,monitor mysql
```


## Addendum: local charms

This is further explanation of offline/local charms.

There are times when it may not be possible to use the charms located in the
official Charm Store. Such cases include:

- The backing cloud may be private and not have internet access.
- The charms may not exist online. They are newly-written charms.
- The charms may exist online but they have been customized locally.

!!! Note: Although this method will ensure that the charms themselves are
available on systems without outside internet access, there is no guarantee
that a charm will work in a disconnected state. Some charms pull code from the
internet, such as GitHub. We recommend modifying these charms to pull code from
an internal server instead.

### Using Charm Tools

Charm Tools is a set of tools that can be useful when using locally stored
charms.

See [Charm Tools](./tools-charm-tools.html) for more information.

#### Installation

Users of Ubuntu 14.04 (Trusty) will need to first add a PPA:

```bash
sudo add-apt-repository ppa:juju/stable
sudo apt update
```

Install the software:

```bash
sudo apt install charm-tools
```

#### Usage

Charm commands are called with `charm <subcommand>`.

The command `charm-help` is used to view the available subcommands. Each
subcommand has its own help page, which is accessible by adding either the `-h`
or `--help` option:

```bash
charm add --help
```

When downloading charms, they end up in a directory with the same name as the
charm. It is therefore a good idea to work from a central directory. For
example, to download the MySQL and the WordPress charms:

```bash
mkdir ~/charms
cd ~/charms
charm pull nfs
charm pull vsftpd
```