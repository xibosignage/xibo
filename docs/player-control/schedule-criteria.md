---
nav: "player-control"
slug: "player-control/schedule-criteria"
title: "Schedule Criteria"
---

# Schedule Criteria

{tip}This feature will be included in Xibo v4.1 which is due to release in the first half of 2024.{/tip}

Schedule Criteria are a set of metrics set on the media player which influence the active schedule loop. Scheduled events in the CMS can have criteria configured against them, so that the event only becomes active when the criteria on the media player match.

For example a metric of "PRODUCT_LIFTED" could be set on the media player via API which activated a new scheduled layout in the loop to show information regarding the lifted product.

## API call
A POST request can be made to the player web server: `POST /criteria` containing a JSON array of criteria to add/update on the player.

```json
[
  {
    "metric": "metric",
    "value": "value",
    "ttl": 60
  }
]
```

## Data Connector
Data Connectors can also set schedule criteria. Setting new schedule criteria will cause the schedule to be reassessed and all events criteria evaluated to build a new schedule loop.

`xiboDC.setCriteria(metric, value, ttl)` is used to set criteria, with the following method signature.

```js
/**
 * Set Schedule Criteria
 * @param {string} metric the name of the metric to be set, this will be matched against  the metrics defined on the scheduled events criteria tab
 * @param {string} value the value to set, this can be a string, integer, boolean, etc
 * @param {int} ttl a time to live in seconds, 0 for permanent
 */
xiboDC.setCriteria(metric, value, ttl);
```

Example:

```js
// Indicate there is a goal and timeout after 30 seconds.
xiboDC.setCriteria('GOAL', true, 30);
```

## Frequency
Players may implement throttling on this function to maintain stability, please do not call it rapidly.