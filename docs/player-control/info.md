---
nav: "player-control"
slug: "player-control/getting-player-information-using-javascript"
title: "Player Info - Player Control"
---

# Player Info

The Embedded, Package HTML and Web Page Widgets, as well as custom Widgets allow HTML, CSS and JavaScript to be embedded into the Player.

## Xibo v2
Starting in Xibo for Android v2 R207 and Xibo for Windows v2 R255 it is possible to call `/info` on localhost to get information about the running player. You can do this from any Widget which uses a browser.

```javascript
$.get("http://localhost:9696/info");
```

This returns:

```json
{
  "hardwareKey": "",
  "displayName": "",
  "timeZone": "",
  "latitude": null,
  "longitude": null
}
```

## Xibo v3
Starting in version 3 of Xibo we have a library available to make consuming the above information easier. You can find this here: https://github.com/xibosignage/xibo-interactive-control

