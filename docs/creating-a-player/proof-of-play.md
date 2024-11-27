---
nav: "creating-a-player"
slug: "creating-a-player/proof-of-play"
title: "Proof of Play - Creating a Player"
excerpt: "Proof of Play statistics are records collected by the Player and transmitted to the CMS which records when an item has been played by the Player."
---

# Proof of Play

Proof of Play statistics are records collected by the Player and transmitted to the CMS which records when an item has been played by the Player. Most commonly used for advertising, but also to measure engagement, Xibo aims to provide as much information as possible with these statistics.

There are 3 types of record recorded:
 - Layout
 - Widget
 - Event

All records are recorded with: 
 - `displayId`
 - `fromDt`
 - `toDt`

In 2.1 onward each record also has:
 - `duration`
 - `count`

### Layout
Layout records represent the play time of the Layout, they contain:
 - `layoutId`
 - `scheduleId`

### Widget
Widget records represent the play time of a Widget, which may be a Layout specific Widget (such as text) and may have an associated library media item (such as video). They contain:
 - `layoutId`
 - `scheduleId`
 - `widgetId`
 - `mediaId` (might be null)

### Event
Event records represent some outside data collected by the Player, such as engagement data or data transmitted to the Player via an API. Event records are also sent with further information about what is being shown by the Player at that time - for example which Layout is Playing. They contain:
 - `layoutId`
 - `scheduleId`
 - `tag`

`tag` is a one word name for the event and should always be the same for occurrences of the same event.

### Collection
XMDS is used to send these records to the CMS as XML in the following structure.

```xml
<stats>
    <stat 
        type="layout|media/widget|event" 
        fromdt="" 
        todt="" 
        layoutid="" 
        scheduleid=""
        mediaId=""
        tag=""  />
</stats>
```

The type of record is indicated by the `type` attribute and is used by XMDS to determine which of the other attributes will be present.

1.8 or later players may send back the `widgetId` attribute instead of the `mediaId` attribute, or may send the `widgetId` as the value of the `mediaId` attribute. This is handled in XMDS by looking up the real `mediaId` using the provided `widgetId`. Earlier Players send a `string` mediaId attribute to indicate a non-media based Widget.



## Collection Mode
Statistics collection can be turned on/off at the Display Settings Profile level. In 2.0 and lower, when statistics are switched on they are recorded for *all* events that the Player experiences.

Starting with 2.1, Xibo supports selectively turning statistics collection on each high level entity, such as the Layout, Widget or Media. Each Campaign and Library Media item can have statistics turned on or off, and then each lower level object can either inherit that setting, or override it to on/off itself. They default for each option can be configured in global settings.

The XLF file in 2.1 contains a new attribute on each `<layout>` and `<media>` node called `stats`, which is either set to 0 or 1, and is used by the Player to determine whether or not it should record a record for that event.



## Aggregation

In 2.0 and lower, statistics are collected at the highest level of detail, called "individual" records. This detail level records and sends a record for each event that occurs.

Starting with 2.1 Xibo supports setting the aggregation level of statistics so that they can be collected by Hour or by Day as well as individually as before. These are global settings and apply to the whole CMS. The new `duration` and `count` fields facilitate this aggregation.

When Hourly or Daily aggregation is selected, the Players will aggregate locally before sending these records to the CMS.



## Sending to the CMS

Proof of Play stats are sent to the CMS using the XMDS service, [documented here](../creating-a-player/xmds#submitstats).



# Storage Engine (CMS)

In 2.1 a `TimeSeriesStoreInterface` is included which provides the interface for implementing an alternative storage engine for the statistics data. If an alternative is implemented it can be instantiated in `settings-custom.php` (or `settings.php` for a manual install).

Xibo provides a `MySqlTimeSeriesStore` class which is the default in all versions. This stores statistics records in a single table called `stat`, with a type column to indicate which type of record is being recorded and null column values when the records do not require a statistics record. 

A `MongoTimeSeriesStore` is also available which stores proof of play records in a MongoDB instance.