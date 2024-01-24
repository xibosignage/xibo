---
nav: "index"
slug: "index"
title: "Introduction"
---

# Developer Documentation

The Xibo Platform offers various opportunities for a developer or designer to be involved in the Digital Signage creative process, and often adding a technical element to your network really makes it come alive. This developer documentation aims to provide guidance on all parts of the platform which have technical elements.

> This documentation is written for a technical audience. If you are looking for a [user manual](https://xibo.org.uk/manual/en/), or [documentation for administrators](../setup), please use the links provided.

These documents are ordered such that more common activities are discussed first, however which parts you need will depend on what you want to achieve; refer to the below overview.

| Section           | Description                                                                                                                                                                                     | Example                                                                                                                                              |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| Widgets           | Learn how to create Embedded or Package HTML Widgets using the Layout Editor, or dive into creating your own Module.                                                                            | Creating a new visualisation for use on a Layout. This may involve pulling data from a 3rd party.                                                    |
| Player Control    | Discover what can be done player side including what information from the Player is available to a Widget, displaying real time data, how to control duration and how to send/receive webhooks. | Interactivity on a player, for example triggering content via a light sensor.                                                                        |
| Themes            | Change the look and feel of the CMS.                                                                                                                                                            | Alter the appearance of the CMS by changing colours and adding logos.                                                                                |
| Integrate         | Connect a 3rd party system by calling the Xibo API. Learn how to authenticate via oAuth and what API calls are available.                                                                       | A 3rd party will push content into Xibo. The Xibo Canva app is a good example of this.                                                               |
| Extend            | Extend the CMS with additional functionality. Learn about the CMS architecture and how to include your own PHP code via Middleware.                                                             | Pull content from a 3rd party or modify the CMS to show data in a different way on a dashboard. Write a dedicated API route for a 3rd party to call. |
| Creating a Player | Not for the feint of heart, but useful if you have a very specific use case, niche hardware requirement or want to contribute to one of the open source players.                                | Learn how Players are expected to communicate with the CMS and how they render content.                                                              |


### A note on Open Source

Full disclaimer we are not lawyers; if you have any doubts always speak to a professional.

Xibo is open source and that has some implications for certain activities. As a general rule if you're entering code into the CMS via the user interface, uploading as package HTML, sending a webhook, developing a module/module template using only the XML definitions supported by the CMS or connecting via the API you are doing so at "arms length" and you can licence your code as you wish.

If you're developing a theme, a custom module which uses a PHP class, a Connector, or extending Xibo then your code does fall under the AGPLv3.


### A note on contributing

If you're doing something cool that you think should be in the core software, then we always have our arms and ears open! We have some guidelines on [Contributing](https://github.com/xibosignage/xibo/blob/master/CONTRIBUTING.md) which you can refer to before you get started.
