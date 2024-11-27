---
nav: "cms-api"
slug: "cms-api/adding-widgets"
title: "Adding Widgets - Integrate with Xibo"
excerpt: "A widget is added to a Layout or Playlist in 4 steps with Xibo Integration. Please note, widgets and data widgets with static templates can be added via the API."
---

# Adding Widgets
A widget is added to a Layout or Playlist in 3 steps:

1. Locate the Module and optional Template you want to add, along with the playlist you want to add it to
2. Call "Add Widget"
3. Discover the properties supported by the module and the template. Any omitted properties will be set as their defaults.
4. Call "Edit Widget" and supply those properties

> Please note, widgets and data widgets with static templates can be added via the API. It is not possible to add Elements via the API.

The add widget API requires a `playlistId`; when working with a standalone playlist this is simply the ID obtained from playlist add or playlist search. However, when working with a layout we either need to add a region for our new widget to sit in, or add it to an existing region.

Once you have a `playlistId` for the region you're adding against, you can use the widget POST API to add the widget. There are two key parameters to this API, aside from `playlistId`.

 - `type`: The module type of the widget you're trying to add. Use the Module Search API to find the one you want.
 - `templateId`: If the module has a `dataType`, provide the ID of a module template returned by the Module Template Search API.

The `templateId` of `elements` is reserved for Elements, but is not available via the API yet.

## Types of region
There are 4 types of region available:

 - `zone`: These are used only in templates and are automatically converted to either a frame or playlist when a widget is added to them
 - `frame`: These are for single widgets (only one widget can be added)
 - `playlist`: These are for multiple widgets which will play in sequence
 - `canvas`: These are for elements and are not yet available via the API as noted above

If you have a `frame` region and you use its `playlistId` to add another widget it will automatically be converted to a `playlist` with both widgets in sequence.

> Regions are not applicable when adding a widget to a standalone playlist.

# Editing Widgets
When a widget is edited it is necessary to provide all properties for that widget's module and it's module template if it has one. Any omitted properties will be set as their defaults. 

# Older versions
Xibo CMS v3.3 and earlier had a more ridged set of API calls for adding widgets and did not cater for custom modules. They were still added in the same process, but the properties supported by the module were already documented in Swagger. 

You can view each of these requests in the Swagger docs for those older versions.
