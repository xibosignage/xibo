---
nav: "widgets"
slug: "widgets/index"
title: "Widgets"
alias: "modules-and-widgets"
excerpt: "Widgets are a core component of Xibo and are used to display content on a Layout or in a Playlist."
---

# Widgets

Widgets are a core component of Xibo and are used to display content on a Layout or in a Playlist. If a user adds some text, an image, or some dynamic content to a Layout they are adding a Widget. A suite of Widgets is provided in the core software, these are discussed in the [user manual](https://xibo.org.uk/manual/en/media_modules.html). 

Xibo has two types of Widget; Widgets and Data Widgets.

Developers can extend Xibo with new Widgets by creating Modules/Templates.

There are two special Widgets included in Xibo which allow a user to configure HTML/CSS and JavaScript to be run on the Player. These are: 

- **Embedded**: use this Widget to add html/css and JavaScript directly in the Layout Editor
- **HTML Package**: use this Widget to provide a ZIP file (with `htz` extension) which the player extracts locally and serves via its web server

You can find out more about these Widgets in the Embedded and HTML Package sections.

{tip}Developers can extend Xibo with new Widgets, via Modules and Templates.{/tip}


## What makes a Widget?

### Modules
All widgets have an associated Module, which tells Xibo what information is required from the user to configure the widget, where the data is for that widget and how it should be displayed.

Modules are created through some or all of:
 - Module XML
 - Widget Provider PHP
 - Connector PHP

These are discussed in the following sections.

Xibo wants developers to make things! We care about the developer experience and welcome any feedback in the [Xibo Community](https://community.xibo.org.uk/c/dev/12).


### Templates
Widgets which rely on data, or "Data Widgets", must use a template to control their appearance. This can be elements, stencils or static templates.

All templates are XML files which describe how to represent a particular type of data, for example an `article` or `social-media`.

Templates are used when a module has a `dataType`. Modules with a `dataType` appear under "Data Widgets" in the Layout Editor.


## Upgrading

We only revise the way modules work between major releases, e.g. `v3` to `v4`, and if there are changes to be made they are described in the associated section shown in the menu to the left.

{tip}Xibo `v4` has extensive changes to the way widgets are modelled and developed. If you are thinking of making a widget, we **recommend** using `v4` as your starting point.{/tip}
