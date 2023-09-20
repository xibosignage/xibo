---
nav: "cms-api"
slug: "cms-api/making-requests"
title: "Adding Widgets - Integrate with Xibo"
---

# Adding Widgets
A widget is added to a Layout or Playlist in 3 steps:

1. Locate the Module and optional Template you want to add, along with the playlist you want to add it to
2. Call "Add Widget"
3. Discover the properties supported by the module and the template
4. Call "Edit Widget" and supply those properties

> Please note, widgets and data widgets with static templates can be added via the API. It is not possible to add Elements via the API.

## Older versions
Xibo CMS v3.3 and earlier had a more ridged set of API calls for adding widgets and did not cater for custom modules. They were still added in the same process, but the properties supported by the module were already documented in Swagger. 

You can view each of these requests in the Swagger docs for those older versions.
