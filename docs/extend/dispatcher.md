---
nav: "extend"
slug: "extend/dispatcher"
alias: "using-the-event-dispatcher"
title: "Event Dispatcher - Extend Xibo"
---

# Event Dispatcher

This section will discuss the CMS event dispatcher, which can be used in Custom Middleware / Modules to intercept various core events raised by the CMS. The CMS uses the Symfony event dispatcher by default.

In order to execute code on an event the object you are listening from must have access to the `$container->dispatcher`, which is an object implementing the `EventDispatcherInterface`.

This is registered in the DI Container by the `State` Middleware and automatically provided to all Widgets.

## Listening for an Event

Event listeners are adding to the event dispatcher for execution when a matching event is fired.

The easiest way to add one is:

```php
$dispatcher = $this->getDispatcher();
$dispatcher->addListener('event.name', function(Event $event) {
    // Your code here
});
```

Each event holds an event object which exposes specific functionality that may be useful for that event.

## Supported Events

Below is a list of supported events:

| Event                              | Class                                   | Description                                                  |
| ---------------------------------- | --------------------------------------- | ------------------------------------------------------------ |
| connector.provider.library         | \Xibo\Event\LibraryProviderEvent        | Fired when a user searches in their library and can be used to provide additional content to display. `Xibo\Entity\SearchResult` objects can be added to the results. |
| connector.provider.library.import  | \Xibo\Event\LibraryProviderImportEvent  | Fired when a user adds one of the search results returned by a `connector.provider.library` event to their Layout. The listener should import the item, save it to the library and then return its ID for adding to the layout. |
| connector.provider.template        | \Xibo\Event\TemplateProviderEvent       | Fired when a user clicks "Add Layout" and can be used to provide additional layout templates to choose from. `Xibo\Entity\SearchResult` objects can be added to the results. |
| connector.provider.template.import | \Xibo\Event\TemplateProviderImportEvent | Fired when the user selected one of the search results returned by a `connector.provider.template` event as their template for Add Layout. The listener should download a Layout Export ZIP to a temporary file and pass that file name back in the event. |
| layout.build                       | \Xibo\Event\LayoutBuildEvent            | Fired at the end of a Layout Build, before the XML has been saved. |
| layout.build.region                | \Xibo\Event\LayoutBuildRegionEvent      | Fired during a Layout build, as each Region has finished processing. |
| maintenance.regular.event          | \Xibo\Event\MaintenanceRegularEvent     | Fired during a run of regular maintenance                    |
| maintenance.daily.event            | \Xibo\Event\MaintenanceDailyEvent       | Fired during a run of daily maintenance                      |



## Using in a Widget

[Guide](developer/extend/events-in-modules)