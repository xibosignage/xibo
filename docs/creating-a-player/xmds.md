---
nav: "creating-a-player"
slug: "creating-a-player/xmds"
title: "Xibo Media Distribution Service - Creating a Player"
---

# XMDS

Xibo Media Distribution Service (XMDS) is a SOAP API published by the CMS and consumed by the Player applications. It is described by a WSDL which can be parsed by many IDEs and tools to produce *client methods* to call the API (for example you can set up a web reference in Visual Studio).

The SOAP service is published over HTTP and HTTPS. HTTPS is the recommended end point and the only option if your CMS runs on the Xibo in the Cloud service.



## Information Exchange

The following pieces of information are exchanged between the CMS and the Players at regular intervals. The exact interval is defined by the `collectionInterval` configured for the Display.

 - Register
 - Required Files
 - Schedule
 - File Download
 - Resource Download *
 - Media Inventory Status
 - Logging
 - Proof of Play Statistics

The 1.7 CMS introduced 2 more

 - Screenshot *
 - Status *

The 3.0 CMS introduced 1 more

 - Report Faults (processed from 3.1 onward)

The 4.0 CMS introduced 2 more

 - Get Dependency
 - Get Data

The starred services usually communicate outside the collection interval because they are driven be events that occur during normal running of the player.




## Security

The CMS is configured with a `secret CMS key` which is a required parameter for all information exchange. The Player is assigned a `hardware key` which is used to identify the player as a **Display** in the CMS. **HTTPS** is recommended at all times to prevent the discovery of this information by a 3rd party.




## Versioning

The API provides various schema versions:

 - v3 - for use by players prior to 1.7
 - v4 - for use by players 1.7
 - v5 - for use by players 1.8+
 - v6 - for use by players 3.0+
 - v7 - for use by players 4.0+

Players which communicate using an older XMDS schema version will only be allowed to connect if it has already been registered to the CMS - new registrations are not allowed. This encourages new players to be commissioned with the latest versions.

When older player are connected they do not support newer features.

The XMDS schema version is only incremented when a breaking change is introduced.



# Methods

Information exchanged between the Player and CMS is driven by the Player connecting to the CMS and calling the appropriate method.



## Life Cycle

It is the decision of the author to decide how the XMDS service is called, however the current players implement guidelines which produce a stable, reliable result.

There are two types of calls, those that happen on the collection interval and those than happen at run time.



### Collection Interval

Each collection interval a set of calls are made to the CMS - some of which can be run in parallel. The required sequence is shown in the numbered list below.

  1. Register Display
  2. Required Files
  3. Schedule
  4. Get File / Resource / Get Dependencies / Get Data
  5. Media Inventory
  6. Submit Stats
  7. Submit Logs
  8. Report Faults

The Player must call `RegisterDisplay` first and parse the response from the Player, if it is not registered it should stop there and not call the subsequent methods. In this case it is common to check at the next collection interval.

The Windows Player calls `RegisterDisplay` during its configuration in the Player Options screen. Even so it must also be called on a timer so that updated settings are received and processed.

Once registered the player may then call `RequiredFiles` and `Schedule`. It is important that all Layouts in the `Schedule` are checked for validity before they are shown as they will appear in `Schedule` and `RequiredFiles` at the same time and may not get have all their files downloaded.

Upon a successful call to `RequiredFiles` the Player must parse the response and queue a request for each layout, media and/or resource *required file*. Depending on the file type and CMS configuration files may be requested via:
 - HTTP
 - `GetFile`
 - `GetResource`
 - `GetDependency`
 - `GetData`

Upon a successful call to `Schedule` the Player must parse the response and determine which Schedules should be put in rotation based on their `from` and `to` dates.

Each time a player requests it's required files it should calculate whether any files need to be downloaded and then call `MediaInventory` with a list of all files status. If there are any files to be downloaded the player should do so and once all pending downloads have been completed it should call `MediaInventory` again with an updated status of each file.

Once complete the Player may submit its cached Stat/Log records to the CMS for processing.

Introduced in Soap6 and processed from 3.1 CMS version onward `ReportFaults` allows Players to send a JSON string with details about the encountered problem.

### Run Time

The run time calls occur outside the normal collection interval and are executed in response to certain events.



#### HTML based widgets
Many of Xibo's widgets are HTML based and should be shown in a web view on the player. The HTML is prepared by the CMS, listed in required files, and available to download via the `GetResource` endpoint.

Resource content should always be cached locally so that the Player can decide the content is fresh or in the event the CMS is unavailable.

##### Data
Starting in CMS v4+ the HTML structure and any associated data are delivered separately. The HTML comes in a `.htm` file and the data in a `.json` file. The data files are listed separately in required files with a type of `widget`.

The player can periodically request new data for any widgets which are actively being displayed. Many of the widgets will automatically refresh their data without reloading the whole widget.

Note: If an older player connects to the CMS, the data will get embedded in the `.htm` file.

#### Submit Screen shot

The Player can submit a screenshot of the current output to the CMS.



#### Notify Status

The player should notify the status when the storage usage significantly changes and when a new layout is shown (if notify current layout is set).



## Rate Limiting

XMDS itself does not implement rate limiting, however it is common for service providers (including Xibo in the Cloud) to add rate limiting at their service loadbalancer or proxy. For this purpose it is important to append the method being called to all XMDS requests. This is done using a query parameter, so `//xmds.php?v=5&method=RegisterDisplay`.

It is important to adopt this convention when implementing a Player because requests without the `method` query parameter are often rate limited severely.

Rate Limited requests will return the HTTP 429 response code and a `Retry-After` header. The Player should repeat the request after waiting the time specified in `Retry-After`. If the `Retry-After` is not present it is convention to wait for the collection interval.

The Xibo in the Cloud rate limit requirements are documented against each method below, but keep in mind that these may not be the same for all service providers.



## Definition v4/v5/v6/v7

The definition of the SOAP service can be automatically consumed from the WSDL at `//xmds.php?v={versionNumber}&wsdl`.

There are 2 common parameters to all Method calls:

 - serverKey: The secret CMS server key.
 - hardwareKey: The Player hardware key used to identify this Player as a Display.



### RegisterDisplay

Register Display is used to add a new display to the CMS or receive updated settings for an existing display.

It takes the following parameters:

 -  serverKey
 -  hardwareKey
 -  displayName
 -  clientType
 -  clientVersion
 -  clientCode
 -  operatingSystem
 -  macAddress

`v5` introduced 2 additional parameters:

 - xmrChannel
 - xmrPubKey

`v7` introduced 1 additional parameter:

 - licenceResult

It returns the following XML string:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<display date="2015-01-01 00:00:00" timezone="Europe/London" status="0" code="READY" message="Display is active and ready to start." version_instructions="" localDate="2015-01-01 00:00:00 +/- timezone">
   <settingsNode>One or more settings nodes</settingsNode>
   <commands>
        <commandName>
            <commandString></commandString>
            <validationString></validationString>
        </commandName>
   </commands>
</display>
```

The Player should interpret the `code` attribute on the root node to see if the Display has been granted access and "licensed" with the CMS. *An administrator can licence a display by logging into the Web Portal, Editing the Display and selecting Licence = Yes*.

The `settingsNodes` are dependent on the `clientType` provided.

The `<commands>` element was introduced in `v5` and contains a list of commands and their command strings. The `<commandName>`
 changes with each command to indicate the actual command code as registered in the CMS.

The `localDate` attribute is only available in CMS 1.8 and above (`v5` and `v4`) and will provide the local display date/time according to the *Display Timezone* setting configured in the Display Profile.



#### XMR

When connected to a `v5` CMS the player is expected to generate a RSA pub/private key and a unique channel. It is expected to provide these details to the CMS on each register call.

The CMS will use the pub key to encrypt any messages sent to the Player on the XMR Public Address. The Player should subscribe to the XMR Public Address using the Channel it sent to `RegisterDisplay`.

Messages sent through XMR are encrypted using `openssl_seal` and should be decrypted accordingly.

Please see [here](software-triggers-using-the-api) for more information.


#### Licence Result
The `licenceResult` parameter has the following options:
 - licensed: The player is fully licensed
 - trial: The player is on a trial
 - na: The player does not require a license, e.g. it is open source, etc


### RequiredFiles

The required files method returns all files needed for the Player to play its scheduled Layouts entirely offline for the quantity of time specified by the `REQUIRED_FILES_LOOKAHEAD` setting in the CMS. This setting defaults to 4 days.

It takes the following parameters:

 - serverKey
 - hardwareKey

It returns the following XML string:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<files>
   <file type="dependency" id="493" size="40408" md5="c90a4c420dd010a5e95dedb8927a29e7" download="http" path="https://cdn/493" saveAs="weathericons-regular-webfont.woff" fileType="asset" />
   <file type="media" id="493" size="40408" md5="c90a4c420dd010a5e95dedb8927a29e7" download="xmds" path="weathericons-regular-webfont.woff" />
   <file type="layout" id="29" size="303" md5="5e6ef3b612b39c83bf8c5cf9f2a75ef5" download="xmds" path="29" code="layoutCode" />
   <file type="resource" id="29" layoutid="1" regionid="3" mediaid="5" updated="102984759" />
   <file type="widget" id="29" updateInterval="3600" />
</files>
```

Each `file` node contains the following attributes:

 - type: Either media, layout, resource or widget
 - id: An ID for the file (unique for all file types except dependency)

Layout and Media file nodes also contain:

 - size: The file size
 - md5: A MD5 of the file to be used as a checksum
 - download: Either `xmds` or `http`
 - path: The intended save path

Layout file nodes also contain:

 - code: An optional attribute indicating if this Layout has a Layout Code set (applicable from v3.0)

Media and Dependency nodes may also contain:

 - saveAs: The file name the player should use when saving the file to local storage
 
Dependency nodes will also contain:

 - fileType: The type of dependency that is being downloaded

Combining a dependency `id` and `fileType` will give a unique ID for that dependency. The `fileType` is needed for reporting Media Inventory.

Resource file nodes also contain:

 - layoutid: The layoutId that references this resource.
 - regionid: The regionId that references this resource.
 - mediaid: The mediaId that references this resource.
 - updated: A timestamp indicating the last time this resource was updated.

Widget nodes are only output for players connecting to XMDS v7 and are used to request data, they will contain:

 - updateInterval: the number of seconds the player should wait before getting a new cache of the file

Each `item` in `purge` node contains following attributes:
 - id: Media ID set to be purged
 - storedAs: the name of the file in Player local storage

#### Parsing
The required files XML should be parsed and each node compared to the local cached copy of that file. A new copy of the file/resource should be downloaded when:

 - the file is not already cached locally
 - the file cached locally has a different MD5
 - the file cached locally is older than when the last update happened in the CMS (resource nodes)
 - the file cached locally is older than the update interval (widget nodes)

Any files/resources that are deemed to be out of date should be downloaded from the CMS again.

#### Purging files

From CMS version 3.1 onward, an additional node `purge` will be present in the XML string:
```xml
<purge>
   <item id="149" storedAs="149.jpg"/>
   <item id="63" storedAs="63.jpg"/>
</purge>
```

Files in purge node should be removed from the Player local storage immediately.


#### Download Type

The CMS supports downloading files over XMDS directly or over HTTP. If HTTP downloads are enabled the `path` attribute will contain a fully qualified download path and a new attribute named `saveAs` will be present showing the intended save path.

HTTP downloads are only valid for one usage and are refreshed with a new `path` each time `RequiredFiles` is called after the CMS sees a change in content that would require the Player to download new media items. This means that RequiredFiles will ordinarily contain links to download content which are not valid any longer if the Player has reported to the CMS that it has downloaded those files successfully.

When the download mode is `xmds` the Player should call `GetFile`/`GetDependency` as appropriate.



#### Resource Files

Resource files are downloaded using the `GetResource` call. The Player implementation is free to save these files with whatever name is most suitable. The Layout XML contains the layout, region and media Ids that can be used to return the relevant cached resource file.

### GetData (Data files for XMDS v7+)

Data files are downloaded using the `GetData` endpoint. They should be saved in the format of `<id>.json` and will be referenced by the associated resource file via the local webserver. 

On download the data files should be parsed by JSON decoding and any new required files content contained in the `files` property assessed and downloaded via HTTP. Each file has the following properties:

 - id
 - size
 - md5
 - saveAs
 - path

These downloads will always be for media files, HTTP and the path a URL.

### GetFile

The `GetFile` method is used to request a chunk (part) of a specific file id. This file **must** have been present in the `RequiredFiles` return otherwise it will not be served.

The `chunkSize` is left to the implementer and should be suitable for the type of network the Player is installed on. It should be noted that the smaller the `chunkSize`, the more I/O load there will be on the CMS.

It takes the following parameters:

 - serverKey
 - hardwareKey
 - fileId: The ID of the file being downloaded.
 - fileType: The type of the file being downloaded.
 - chunkOffset: The offset for the current file chunk being requested. Starts as 0.
 - chunkSize: The size for the current file chunk.

It returns base64 encoded binary data representing the requested file, offset and size. The Player is responsible for reassembling the file and checking the MD5 of the completed file against the one provided in `RequiredFiles`.



### GetResource

The `GetResource` method is used to request the HTML representation of a media item on a Layout in a Region. The CMS will calculate the necessary HTML to correctly display that media item once opened in a correctly sized webview.

The Layout XLF determines when a resource file should be loaded or when a native component is needed.



### MediaInventory

The `MediaInventory` method is used by the Player to update the status of its cached files in the CMS. The CMS uses this information to present the status of each Display in the "Displays" page. If all file nodes are set to `complete="1"` the Display status in the CMS will be updated to complete and the Display row shown as green.

It takes the following parameters:

 - serverKey
 - hardwareKey
 - mediaInventory: XML representation of currently cached files vs required files.


The XML structure for media inventory is:

``` xml
<files>
	<file type="media|layout|resource|dependency|widget" id="1" complete="0|1" md5="c90a4c420dd010a5e95dedb8927a29e7" lastChecked="1284569347" fileType="dependencyFileType" />
</files>
```

 - type: the type of file being reported for, either media, layout or resource
 - id: the ID of the file.
 - complete: whether the file is complete or not.
 - md5: the md5 of the file in the local cache.
 - lastChecked: a unix date/time for when the file was last by the player checked.
 - fileType: only used for dependencies, this is the file type provided in required files for the dependency



### Schedule

The `Schedule` method call provides the Player with a date/time aware set of Layouts that need to be played. The time window of schedule returned is controlled by the CMS setting `REQUIRED_FILES_LOOKAHEAD` if the `SCHEDULE_LOOKAHEAD` setting is `On`.

It takes the following parameters:

 - serverKey
 - hardwareKey

It returns XML in the following format for v5/v6:

```xml
<schedule>
    <default file="4">
        <dependants>
        <file>5.jpg</file>
        </dependants>
    </default>
    <layout file="5" fromdt="" todt="" scheduleid="" priority="" shareOfVoice="" duration="" isGeoAware="" geoLocation="" cyclePlayback="" groupKey="" playCount="">
        <dependants>
         <file>5.jpg</file>
        </dependants>
    </layout>
    <dependants>
        <file>5.jpg</file>
    </dependants>
    <command code="CODE" date="" />
    <overlays>
        <overlay file="5" fromdt="" todt="" scheduleid="" priority="" isGeoAware="" geoLocation=""></overlay>
    </overlays>
    <actions>
        <action fromdt="" todt="" scheduleid="" priority="" isGeoAware="" geoLocation="" syncEvent="" triggerCode="" actionType="" layoutCode="" commandCode=""/>
    </actions>
</schedule>
```

The `shareOfVoice` property may not be present if the CMS is a version earlier than 2.2. If it doesn't exist the Player should assume a value of 0.

The `isGeoAware` and `geoLocation` properties may not be present if the CMS is a version earlier than 2.3.

The `duration` property may not be present if the CMS is a version earlier than 2.3.10.

The `actions` node was introduced in 3.1 CMS version.

The `cyclePlayback`, `groupKey` and `playCount` properties were introduced in 3.1 CMS version.

It returns XML in the following format for v4 and below:

```xml
<schedule>
	<default file="4" />
	<layout file="5" fromdt="" todt="" scheduleid="" priority="" dependents="" />
	<dependants>
		<file>5.jpg</file>
	</dependants>
</schedule>
```

The from and to dates are ISO formatted dates in the CMS time zone.



#### Default Layout

If there aren't any Layouts in the Schedule window then the default Layout should be shown. If the Display is set to *interleave default* in the CMS then the Layout will appear as a `<layout>` element and no additional logic is required.



#### Priority

The priority attribute determines whether a Layout is in the priority schedule or normal schedule. Priority schedules should be shown in preference to normal ones.

The attribute will either be empty or contain an integer value - when empty a value of 0 should be assumed. Only the highest priority layouts should be included in the schedule at any time.



#### Dependants

A list of global dependencies is provided in the `dependents` element. This is a list of files that must be in the cache before any Layouts can be considered valid. These *global dependencies* are provided as the first entries in `RequiredFiles` XML.

A Layout may also have dependants specific to itself and these are provided either as an attribute on the layout node (v3,v4) or as a `<dependents>` child node (v5). Layout specific dependants should be checked in the off-line cache before the Layout is considered for playback.

**Starting in v5 the default layout also has a `<dependents>` child node.**



#### Overlays

**Starting in v5** overlay nodes may be provided in the overlays element. These describe layouts that should be overlaid on top of the normal layout schedule.

Overlays have a from/to dt, scheduleId and priority which have the same meaning as a normal `layout` node. The order of `overlay` nodes determines the order in which the overlay
layout regions should be applied, starting with the first and stacking on top.

Overlays should be applied on top of the existing Layout schedule and remain there while they are still considered to be in the schedule.



#### Share of Voice

**Starting in v5 and in CMS versions of 2.2 and later**, the `shareOfVoice` property greater than 0 on a Layout indicates that the event should be considered an Interrupt Layout. Interrupt Layouts should be parsed into a separate schedule list by the Player and treated differently to the normal flow of events.

The share of voice parameter indicates the percentage of time which should be given aside to the Interrupt Layout. Interrupt Layouts appear in the schedule with all the usual properties of a normal layout, such as priority, display order, geoaware, etc. The player should make a list of normal and a list of interrupt layouts and then combine them such that an entire hour is represented and the share of voice requirements met.

A layout should always play through from start to finish - the purpose of an interrupt layout is to interrupt the normal schedule with an extra ordinary event.

_Note: prior attempts at this functionality used a pause/resume methodology to interrupt the currently running normal layout and continue once the interrupt had completed. This proved unreliable and the methodology was changed as above in time for the later v2 players. We recommend any new player implementations use the newer methodology for consistency._

#### Actions
**CMS version 3.1 and later**, the `actions` node was added to the schedule XML.

The `action` nodes are generated from an event type introduced in CMS version 3.1 called Action, which allows for scheduling an interactive Action directly to the Player.
There are two use cases: 
- Command : `actionType` parameter set to `command` and `commandCode` that should be executed when `triggerCode` webhook is sent to the Player.
- Layout : `actionType` parameter set to `navToLayout` and `layoutCode` with code identifier of the Layout that should be displayed when `triggerCode` webhook is sent to the Player.
The Layout linked to this action type will be included in RequiredFiles XML.
  
#### Cycle Based Playback
**CMS version 3.1 and later**, the The `cyclePlayback`, `groupKey` and `playCount` properties were introduced.

Campaigns can be configured to use cycle based playback with specified playCount, when one of such Campaigns is scheduled to the Player, the mentioned properties will be populated in Schedule XML.

The `cyclePlayback` property comes from the Campaign, if it is enabled, then two following properties should be correctly interpreted by the Player.

The `groupKey` is the ID of the scheduled Campaign, which helps the Player to recognise which Layouts are grouped in the same Campaign.

The `playCount` is a number of plays should each Layout in the same group have before moving on.

### SubmitLog

The `SubmitLog` method is used by the Player to send useful audit/error logging information back to the CMS. The log messages should be kept to a minimum to prevent unnecessary traffic. The log level is defined in the Display Settings and defaults to "error".

It takes the following parameters:

 - serverKey
 - hardwareKey
 - logXml: XML representation for Log Messages



> Be kind to your CMS! Log messages should be batched in packages of no more than 50 records. If a backlog of messages is building, 300 records can be sent at one time until the backlog has been cleared.



#### Log XML

The structure for Log XML is as follows:

``` xml
<logs>
	<log date="Y-m-d H:i:s" category="">Message</log>
</logs>
```

or it can provide more information

``` xml
<logs>
    <log date="Y-m-d H:i:s" category="">
        <type>type</type>
        <type>thread</type>
        <type>method</type>
        <type>message</type>
        <type>scheduleID</type>
        <type>layoutID</type>
        <type>mediaID</type>
    </log>
</logs>
```

 - date: The local date, ISO formatted.
 - category: Either error or audit. Audit messages are discarded unless auditing is switched on globally and on the display.
 - type (optional): The type.
 - message: The log message
 - method (optional): The method.
 - thread (optional): The Thread that the log message executed on.



### SubmitStats

The `SubmitStats` method is used to report Proof of Play statistics to the CMS.

It takes the following parameters:

 - serverKey
 - hardwareKey
 - statXml: XML representation for Proof of Play Statistics



> Be kind to your CMS! Stats messages should be batched in packages of no more than 50 records. If a backlog of messages is building, 300 records can be sent at one time until the backlog has been cleared.



#### Stat XML

The structure for Stat XML is as follows:

``` xml
<stats>
	<stat type="" fromdt="" todt="" scheduleid="" layoutid="" mediaid="" duration=0 count=1></stat>
</stats>
```

 - type: The type of stat record, either layout or media.
 - fromdt: The ISO date that the layout/media started playing.
 - todt: The ISO date that the layout/media finished playing.
 - scheduleid: The ID of the schedule that caused the Layout/Media to be shown.
 - layoutid: The layoutId.
 - mediaid: The mediaId.
 - duration: The number of seconds for this record (if Hourly/Daily aggregation is enabled this will not be equal to the from/to dates)
 - count: The number of events represented by this record (if Individual records are enabled this will always be 1).



#### Aggregation Level

**Starting from v5 and CMS 2.1 or later**, a Player can be configured to collect statistics in 3 aggregation levels:

 - Individual
 - Hourly
 - Daily

When in Hourly or Daily the Player should aggregate the statistics records to either the hour or day accordingly, before they are sent. Events which cross the aggregation period (e.g. 22:56 to 23:02) should be split between hours. 4 seconds in the 22:00 period and 2 seconds in the 23:00 period.

This also means that the Player must wait until the period is over before sending statistics - i.e it cannot send 22:00 to 23:00 until after 23:00. For more information see [collecting proof of play](../creating-a-player/proof-of-play).




### NotifyStatus

The `NotifyStatus` method is used by the Player to update the CMS on various events in the Player life cycle.

It takes the following parameters:

 - serverKey
 - hardwareKey
 - status: JSON encoded key/value string of properties to update on the display.

Properties supported by `status` are:

``` json
{
    "currentLayoutId": "The ID of the Current Layout",
    "availableSpace": "The bytes of available space",
    "totalSpace": "The bytes of total space",
    "lastCommandSuccess": "Whether or not the last received Command was executed successfully",
    "deviceName": "The name of the physical device",
    "timeZone": "An IANA timezone identifier for the Displays timezone",
    "latitude": "The current or last known latitude",
    "longitude": "The current or last known longitude",
    "statusDialog": {} // A json string representing up to date status information from the player
}
```



### SubmitScreenShot

The `SubmitScreenShot` method call is used by the Player to send a screenshot of the current playback to the CMS. The instruction to send a screenshot appears in the `RegisterDisplay` call settings.

It takes the following parameters:

 - serverKey
 - hardwareKey
 - screenShot: Base64 encoded binary representation of the screenshot image.

### ReportFaults (Soap6)

The `ReportFaults` method is used by the Player to send details about any issues it encountered back to the CMS.
This data is then presented on the Display Manage page in the CMS.

It takes the following parameters:

  - serverKey
  - hardwareKey
  - fault: JSON encoded key/value string of properties with fault details.

Properties supported by `fault` are :
``` json
{
    "code": "The error code (integer)",
    "reason": "The reason of the fault (string)",
    "date": "The date the incident occured (dateTime string, Format Y-m-d H:i:s)",
    "expires": "The date the fault expires (dateTime string, Format Y-m-d H:i:s)",
    "layoutId": "The ID of the affected Layout (integer)",
    "regionId": "The ID of the affected Region (integer)",
    "widgetId": "The ID of the affected Widget (integer)",
    "scheduleId": "The ID of the affected Schedule event (integer)",
    "mediaId": "The ID of the affected Media (integer)"
}
```



## Rate Limiting

Your CMS may issue a `429` HTTP response code to rate limit your requests. If you receive a 429 response code the CMS is too busy to service your request and you should try again later. A `Retry-After` header will be included which gives a number of seconds you should wait before retrying.