---
layout: snappy-dev-default
title: Store
permalink: /snappy-dev/store/
---
# Ubuntu Store

Snaps are distributed to snapd devices through [the Ubuntu Store](https://myapps.developer.ubuntu.com/dev/click-apps/ "Ubuntu store"), where you can customize how your snap is presented, review each new upload, and control publishing.

You'll choose a unique developer namespace as part of the account creation process. 

Uploading snaps to the store can be done directly from the [snapcraft](../snapcraft_intro.md "snapcraft upload") tool or on the [store website](https://myapps.developer.ubuntu.com/dev/click-apps/ "Ubuntu store"). Once uploaded you choose the [channel](channels "channels") that the snap will be published to (the upload command returns the URL of the page you need to visit to do this). After you've chosen a channel, your application is sent for review. Most apps are reviewed by way of automated checks, but if your app uses sensitive interfaces it may be manually reviewed -- you can find more details on the review process [here](https://developer.ubuntu.com/en/publish/application-states/). Once your snap has been reviewed and approved, you can publish it when you're ready, making the snap be available to users.

It's also worth noting that the store automatically gives your snap a new revision number when you upload it.

You can publish a snap under any name you have rights to and you can registered a name by clicking **New Snap** on the developer portal, or by visiting the [Register name](https://myapps.developer.ubuntu.com/dev/click-apps/register-name/ "register name") page. You can also provide other developers with permission to publish versions of the snap, for example as part of an open source project.