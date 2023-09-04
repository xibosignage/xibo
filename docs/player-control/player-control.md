---
nav: "player-control"
slug: "player-control/index"
title: "Player Control"
---

# Player Control

Xibo Players receive their instructions for what to play from the CMS, they download everything they need and then run through the instructions rendering output to the screen. A lot can be achieved using this standard functionality, particularly when combined with the more advanced embedded/HTML package Widgets. However, in this mode of operation screens are limited when it comes to interacting with their environment.

Starting in Xibo `v3`, an interactive control component has been introduced to allow a screen to fully interact with its environment through:

- **Touch**: physical interaction with the screen, usually via a touch screen or mouse
- **Web hooks**: software interaction with the screen via `http` request, usually from another device or service



Interactive control also allows for more advanced usage of the embedded/HTML package options through the "interactive control" JavaScript library. This library provides method for getting player information and controlling the duration of Widgets.