---
nav: "widgets"
slug: "widgets/package-html"
title: "HTML Package - Widgets"
---

# HTML Package

Package HTML Widgets are uploaded to Xibo's Library and assigned to one or more Layouts/Playlists. HTML packages allow an entire HTML structure to be distributed to players, extracted and then a nominated URL opened (usually `index.html`). The major advantage of this over using a web page is that your HTML will be local to the player and available even if the Player loses network connectivity.

Unlike Embedded Widgets, the Player does not inject any of its core libraries, although it will attempt to call `xiboIC` in case interactive control has been included (see player control).



### Referencing Resources

Your entry point (`index.html`) will likely need to reference other files, be they scripts, style sheets or images. These resources must be referenced relatively, because your entire package will be inside a folder. You are guaranteed that the folder structure is only one level deep, for example `http://localhost:9696/package_1234/index.html`.



### CORS

HTML packages will be opened on the Player's embedded web server, run on port 9696 by default. This means any XHR requests you make will be cross origin. If this is not acceptable for your use case then the only option remaining is a Web Page Widget and external hosting for your content.



### Player Browser Versions

Where possible Xibo player implementations choose the chromium rendering engine, but effort should be made to thoroughly test your package HTML on the player it is intended for, or to make it cross browser.



### Player Control

HTML Package Widgets can also make use of the API's available for Player Control - [see here](../player-control/getting-player-information-using-javascript).

