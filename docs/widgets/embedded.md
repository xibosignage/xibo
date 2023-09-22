---
nav: "widgets"
slug: "widgets/embedded"
title: "Embedded - Widgets"
---

# Embedded

Embedded Widgets are configured in the Layout/Playlist Designer directly in the CMS user interface. The purpose of the Widget is to generate a HTML file which be combined with some Player provided libraries and will be rendered on the Player.

Their core configuration consists of 3 items:

- **HTML to Embed**: HTML injected into a content `<div>` 
- **Custom Style Sheet**: A style sheet which will be injected into the final rendered HTML.
- **JavaScript**: Any JavaScript you want to define (`<script>` tags not required)

The contents in HTML and Custom Style Sheet will also be parsed for library substitutions. These are `[]` tags containing a `mediaId` from the Library, and can be used to reference images and other stored files.



### Page Load

The player will receive a HTML file which is the combination of some player libraries (such as jQuery) and the items entered above. It will load the HTML file using its internal web server, and then call a the `EmbedInit()` function. It is left up to the developer what this function does.

```js
function EmbedInit()
{
    // Init will be called when this page is loaded in the client.
    return;
}
```

It will also optionally run the Xibo Layout Scaler if "Scale Content?" has been checked in the Widget configuration.



### Player Control

Embedded Widgets can also make use of the API's available for Player Control - [see here](../player-control/getting-player-information-using-javascript).
