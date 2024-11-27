---
nav: "player-control"
slug: "player-control/index"
title: "Player Control"
excerpt: "Xibo has several tools available to connect displays to their environment and to each other. Interactivity, Real time data, & Schedule Criteria..."
---

# Player Control

Xibo Players receive their instructions for what to play from the CMS, they download everything they need and then run through the instructions rendering output to the screen. A lot can be achieved using this standard functionality, particularly when combined with the more advanced embedded/HTML package Widgets. However, in this mode of operation screens are limited when it comes to interacting with their local environment.

Xibo has several tools available to connect displays to their environment and to each other.

## Interactivity

Starting in Xibo v3, an interactive control component has been introduced to allow a screen to fully interact with its environment through:

- **Touch**: physical interaction with the screen, usually via a touch screen or mouse
- **Web hooks**: software interaction with the screen via `http` request, usually from another device or service

Interactive control also allows for more advanced usage of the embedded/HTML package options through the "interactive control" JavaScript library. This library provides method for getting player information and controlling the duration of Widgets.

## Real time data

Starting in Xibo v4.1, a Data Connector component has been introduced to allow a player to connect to a data source, serial/network device or sensor, and display data from that source in real time.

## Schedule Criteria

Starting in Xibo 4.1, players can be made aware of their environment via metrics such as "weather: current temperature" and have their schedule adapt in real time based on these metrics.

Schedule Criteria can also be set via a Data Connector and/or API call enabling the player to be fed local, real time conditions.
