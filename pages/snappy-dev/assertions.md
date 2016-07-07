---
layout: snappy-dev-default
title: Assertions
permalink: /snappy-dev/assertions/
---
# Assertions

Assertions are digitally signed documents that provide the Snap store with knowledge about snaps and users. They are the basis of trust and control between developers of devices, developers of software, anyone managing devices, and the user of a device. 

Assertions are held in a database within the store and referenced when the store or Snapd System on a device undertakes various actions on snaps and users. This means that snaps (and their hash) remain unchanged from their original version, even though the secure information controlling their use may change.  

In most cases assertions will be handled transparently, as part of the normal snap development and distribution process. Developers and users won't normally need to create assertions and attach them to snaps or users.

The following information is therefore provided as background to the assertion system: no further knowledge should be needed to develop and distribute snaps.


## IDs

Entities in the snap store will each have a unique “id”. The id used  is a sequence of 32 random characters taken out of an alphabet of 62 characters (uppercase letters + lowercase letters + numbers), for a total of 310 bits of space. This means ids are case sensitive.

These ids are generated centrally or delegated to known parties. In most cases
ids aren't exposed in the primary user interface or used in everyday operations or development.

## The Assertion format

An assertion consists of a set of headers, optional body content, and a signature. The typical format of an assertion, with common headers, is as follows:

    type:          single-word  // eg “account” or “model” or “model-snap-cert”
    authority-id:  account-id   // on whose authority this assertion is made
    series:        value
    index-item-1:  value        // identifying the object of this assertion
    index-item-2:  value
    ...
    revision:      integer      // assertions can be updated with a higher revision
    
    BO                          // free-form text
    
    signature                   // both key id and signature itself

Assertions have a media type of `application/x.ubuntu.assertion`.

## The signature

The signature on an assertion follows the OpenPGP ASCII armored format, as described in [RFC 4880](https://tools.ietf.org/html/rfc4880).

## Assertion validation
In order to validate an assertion, the Snapd System will ensure that:

1. The content of the assertion (headers and body) is correct for the assertion type.
2. The `authority-id` is appropriate for the particular assertion type and objects it describes. For example, if asserting details about a snap, the authority must be the publisher (or their delegate).
3. If the authority isn't also the signatory, the signatory is appropriately empowered by the authority-id.
4. The signing key has been defined as appropriate for the purpose of signing this type of assertion.
5. The signature on the assertion is valid with that key.

## Types of assertion

The types of assertions used in the Snapd System are:

- Personal and institutional assertions based around a Snap Store account-id, which are used to describe the:
   - Account name.
   - Account's public keys.
   - Types of assertions the account keys can be used on. 
- Device assertions, that define the:
   - Device model.
   - Device serial number.
   - Certification status (whether a device model is guaranteed to get security and stability updates).
   - Ownership.
- Snap assertions, that define the:
   - Snap name.
   - Snap's build.
   - Stores a snap can be distributed in.
   - Monetization model (whether the snap is free or paid).
   - Ownership.
   - Gated updates status.
- Store assertions, which define:
   - Delegation of responsibility, such as those of a publisher to a developer.

## Roles within an assertion

Individuals or organizations will have one account within the Snapd System, however they can perform various roles and make assertions on the basis of those roles:

- Brand, the creator of a device model or device models.
- Publisher, the controller of a snap's publication and distribution rules.
- Developer, who writes and publishes software (but may not own the policies for that software).
- Owner, who has control of the policies that govern the use of a device.
- User, a person who can logon to and operate a device. 
 

 
