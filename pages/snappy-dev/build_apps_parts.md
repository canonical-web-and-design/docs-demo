---
layout: snappy-dev-default
title: Parts
permalink: /snappy-dev/build_apps_parts/
---
#Parts

Parts are reusable components that are the main building block used to create snaps using Snapcraft. Parts have their own private space and lifecycle. Each part uses a plugin, which tells the part how to behave and what to do with the information inside it. Parts are analogous to a library that you would call in your program. There are three types of parts:

- Parts from local source that use local files on your machine. For example (as seen in `10-SNAPS/01-service/`<sup>1</sup>):

         parts:
           hello:
             plugin: nodejs
               source:

- Parts from online sources, such as `github`, `bzr`, `tarball`, or any code repository you like. For example (as seen in `00-SNAPCRAFT/01-easy-start/`):

        parts:
          godd:
           plugin: go
            source: https://github.com/mvo5/godd.git
          gnu-hello:
           plugin: autotools
            source: http://ftp.gnu.org/gnu/hello/hello-2.10.tar.gz

- Parts built and shared by others through the [Ubuntu Wiki](https://wiki.ubuntu.com/snapcraft/parts). For example, using a part for curl defined in the wiki:

        parts:
            client:
               plugin: autotools
               source: .
               after: [curl]

## Defining parts in snapcraft.yaml

The snapcraft.yaml key `parts` defines a map of the parts you want to include in your snap. Sub-keys enable you to define how those parts are configured when your snap is build. The sub-keys as as follows: 

Key | Type | Purpose
:----- | :---- | :-----
`plugin` | (string) | Specifies the plugin that will manage this part.  Snapcraft will pass the plugin all the other user-specified part options, those options defined with the other keys below. <br />There are three way in which the plugin can be defined: <ul><li>A plugin name, to use a build-in plug-in.</li><li>A local path, for example `parts/plugins/x-plugin_name.py`, to use a local (custom defined) plugin. For more information, see [Building Your Own Plugin](../build_apps_plugin).</li><li>If `plugin` is not defined, the plugin defined for the part in the [Ubuntu Wiki](https://wiki.ubuntu.com/snapcraft/parts).</li></ul>
`after` | (list of strings) | Specifies any parts that should be built before this part, which Snapcraft then stages before trying to build this part.  This is useful when a part needs a library or build tool built by another part. <br />If the part defined in `after` is not defined locally, the part will be search for in the [wiki](https://wiki.ubuntu.com/snapcraft/parts).
`stage-packages` | (list of strings) | A list of Ubuntu packages to use that are needed to support the part creation.
`filesets` | (yaml subsection) | A dictionary with filesets, the key being a recognizable user defined string and its value a list of strings of files to be included or excluded. Globbing is achieved with * for either inclusions or exclusion. Exclusions are denoted by a -.<br />Globbing is computed from the private sections of the part.
`organize` | (yaml subsection) | A dictionary exposing replacements. The key is the internal name while the value the exposed (replacement) name (for example, `source_name: map_name`). **Note**: `filesets` refer to the exposed names of files, after the organization has been applied.
`stage` | (list of strings) | A list of files from a part’s installation to expose in stage. Rules applying to the list here are the same as those of filesets. Referencing of fileset keys is done with a $ prefixing the fileset key, which will expand with the value of such key.
snap | (list of strings) | A list of files from a part’s installation to expose in the snap. Rules applying to the list here are the same as those of filesets. Referencing of fileset keys is done with a $ prefixing the fileset key, which will expand with the value of such key.

You can define your parts in any order, `after` takes care of any required build order.

## Working with Snapcraft parts

You've a number of ways in which to incorporate parts into you snaps. For example, you may want to enhance your part’s functionality using `stage-packages` to bring Ubuntu deb-based packages into your part, `filesets` to declare inclusion and exclusion sets, `organize` so make the artifact output for your part neater, `stage` and `snap` to make certain only the right set of files is seen at each stage (making use of filesets or not). An example integrating these concepts for a part called `example-part` using a plugin called `null` would look like:

     parts:
       example-part:
         type: null
         stage-packages:
           - gnupg
           - wget
         organize:
           usr/bin: bin
         filesets:
           binaries:
            - bin/*
            - usr/bin/*
           headers:
            - “*.h”
            - -include
         stage:
           - $binaries
           - test/bin/test_app
           - $headers
         snap:
           - $binaries
 
In this example, the `null` plugin builds something in its private build location using its private source directory as a base, and it installs the usual set of files to the file, except it will install the part’s private install directory.

This `null` plugin makes use of `stage-packages`, these packages are fetched from the Ubuntu deb archive using the series (release, i.e.; trusty, vivid, wily, …) that is being used on the host. In this case, the part will be enhanced by the `gpg` and `wget` deb packages and its necessary dependencies to work isolated inside the part.

When reaching the stage phase, the components in the private part’s install directory will be exposed there, but since the `organize` key is being used the contents in the install directory will be exposed to other parts in a cleaner form if desired or required; it is important to notice that when using `filesets` they will follow the organized files and not the internal layout.

The concept of `filesets` enables the creation of sets named after the keywords defined within, in this case binaries and headers, these are not necessarily needed but allow for variable expansion in the common targets: stage and snap. An inclusion is defined by just listing the target file, it can be globbed with * and a file can be explicitly excluded by prepending a - (when using * at the beginning of a path it needs to be quoted).

The `stage` key then:

- replaces `$binaries` will be the binaries defined in filesets.
- Adds `test/bin/test_app` to the stage file set.
- `$headers` will include all the header files, except those from `include` as it is suffixed with -, indicating these files should be excluded.

These are the files that will be moved to the stage directory.

The behavior for the snap step is identical to stage except that the file manipulation is applied to the snap directory, which is the final file/content layout for the snap. This is where everything should look clean and crisp for a good quality snap.

##Snapcraft for Python with PIP

Snapcraft includes support for Python 2.x and Python 3.x parts; here’s how a snapcraft.yaml parts section will look:

     parts:
       spongeshaker:
         plugin: python3
         source: git://github.com/markokr/spongeshaker.git

A Python part will typically make sure that the required Python packages are installed on the build host and embed the following pieces in your snap:

- latest Python runtime from the latest Ubuntu packages of your current Ubuntu release
- latest PIP for this Python version as downloaded from PyPy
- latest versions of your PIP requirements

The proper **PYTHONPATH** environment variable will also be set in the wrapper scripts generated by Snapcraft or when running your app locally.

Python parts support standard Snapcraft options and the requirements option to point PIP at its requirements file.

###Embedding a Python runtime

While the Snapd System include a Python runtime, this might not be the one you need, and it might be updated to a different version or removed in a Snapd System update. This is why applications using Python should embed their copy of the Python runtime.

##Snapcraft for Java, Maven or Ant

Snapcraft includes support for building parts with Apache Maven or Ant; here’s how a snapcraft.yaml parts section will look:

    parts:
        webapp:
            plugin: maven
            source: git://github.com/lool/snappy-mvn-demo.git

A Maven part will typically:

- Make sure the tool is installed on the build host.
- Embed a Java runtime in your snap.
- Run mvn package and copy the resulting `*.jar` and `*.war` files in your snaps `jar/` and `war/` directories.

An Ant part works similarly, except it runs ant and sets the proper **CLASSPATH** environment variable in the wrapper scripts generated by Snapcraft or when running the app locally.

If you only need to embed a Java runtime, add a part with the `jdk` type. This will pull a relocatable OpenJDK via the default-jdk Ubuntu package and will set the proper **JAVA_HOME** and **PATH** environment variables in wrapper scripts generated by Snapcraft or when running the app locally.

## Exercise

The features of parts shared through the [wiki](https://wiki.ubuntu.com/Snappy/Parts) is the focus of the exercise:

    $ cd ../../20-PARTS-PLUGINS/01-reusable-part
    $ snapcraft
    $ sudo snap install hello-world-desktop_0.1_*.snap

Which can be run with the `hello-world-desktop` command as defined in the `snapcraft.yaml`:

    apps:
        hello-world-desktop:
          command: qt5-launch hello-world-desktop

But notice this involves an extra tool `qt5-launch`, which prepares the environment for launching the real application. These `qt5-launch` and `hello-world-desktop` commands come from:

    parts:
      hello-world:
        plugin: cmake
        source: src/
        build-packages:
          - qtbase5-dev
        stage-packages:
          # Here for the plugins-- they're not linked in automatically.
          - libqt5gui5
        after: [qt5conf] # A part in the cloud

In this part definition:

*   `build-packages` lists the dependencies needed to build the contents of the snap. These aren't packed into the final snap. `qtbase5-dev` has been specified here since that package contains the headers, libraries, and tools needed to build the app
*   `stage-packages` lists the dependencies needed to actually run the contents of the snap. They'll be packed into the final snap. Here, the requirement is for the hello-world part to download and unpack `libqt5gui5` with all its dependencies. This method can reuse any of the 48000 .deb packages that traditional Ubuntu provides. It's really that easy: just specify the packages you need embedded into your snap
*   `after:` [`qt5conf`] lists the parts that must be staged before this part can be built. However, you may have noticed that this YAML doesn't actually contain the `qt5conf` part. That's because it's a part in the cloud, which is a way for collaborating, reusing, and sharing already-written parts. The previously mentioned `qt5-launch` tool comes from the `qt5conf` part, without any additional effort from you. This way you can make use of and build upon what others have created

## Sharing your parts with other developers

If you would like to publish your own parts, you can contribute them on the [Ubuntu Wiki](https://wiki.ubuntu.com/snapcraft/parts).

-------
(1) Examples on this page are from the Snapcraft tour, which is installed by running `$ sudo snapcraft tour`.
