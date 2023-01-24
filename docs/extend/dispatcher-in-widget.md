---
nav: "extend"
slug: "extend/events-in-modules"
alias: "using-events-in-custom-widgets-to-alter-the-xlf-file"
title: "Events in a Custom Widget - Extend Xibo"
---

# Using events in a Custom Widget

Xibo includes a powerful event mechanism which allows for custom code to hook into system events and make changes to objects before they are finalised. In the context of a custom Widget this mechanism can be used to change the contents of the XLF file before it is saved and sent to the Player.

*Available in: 1.8.0. and later*

Xibo uses Symfony's Event Dispatcher which implements the PSR `EventDispatcherInterface`.

There are two events available from within a Widget module, these are:
 - Layout Build (`Xibo\Event\LayoutBuildEvent`)
 - Layout Build Region (`Xibo\Event\LayoutBuildRegionEvent`)

### Layout Build
This event receives the Layout object and XLF XML document once it has been completely generated, just before it is saved.

The event handler can make adjustments to the XML document (a `DOMDocument`) and return it for those adjustments to be written into the final XLF document.

### Layout Build Region
Similar to the Layout Build event, this receives each Region XML node along with a `regionId` for that node as the Layout's XLF file is being built.

The event handler should return the region node with any alterations to be added to the document.

## Registering with the Dispatcher
In order to receive events a custom widget, specifically its module code, must register handlers for the events with the event dispatcher.

This is done by overriding the Module `init()` function.

```php
public function init()
{
    // Always call the parent init method
    parent::init();

    // Get the dispatcher
    $dispatcher = $this->getDispatcher();

    // Register our listener
    $dispatcher->addListener('event name', function($event) {
        // Handle event
    }
}
```

If your module is assigned to a Layout, it will be initialised during the Layout build process, which will in turn initialise your event listener. The listener will then receive the named event and be able to modify the end XML generated for that Layout.

## Use Case
The event mechanism is useful when a custom module wants to manipulate the XML generated for a Layout, and particularly interesting when used in conjunction with a `getResource` method that sets the Layout status to `building`.


### General Example
Following is a general example of what might be achieved and is intended as a starting place for development.

```php
public function init()
{
    parent::init();

    // Register our interest in certain events
    $log = $this->getLog();

    // Store a reference to this module so that we can pass it into the listener
    $module = $this;

    $dispatcher = $this->getDispatcher();
    $dispatcher->addListener(LayoutBuildRegionEvent::NAME, function(LayoutBuildRegionEvent $event) use ($log, $module) {
        // We only want to action this once, as we are going to completely modify the XML doc
        $event->stopPropagation();

        $log->debug('Start processing event');

        // Get our region node
        $regionNode = $event->getRegionNode();

        // Loop over the region's child nodes looking for one with our widgetId in the `id` attribute
        // or we could use XPath here - its down to the developer
        
        // if we find our node, do something with it, such as remove it

        // if we remove it, check whether the region is empty - if so we should add something like a transparent image or empty text so that our region is still valid, but expires immediately
        // or perhaps if this is likely we should use the LayoutBuild event instead and remove our whole Region (or mark the Layout as invalid so its removed from the Schedule).

        // If we have some nodes we'd like to add we can do so here.
        // we need to make sure we create the options they require to run
        $mediaNode = $regionNode->ownerDocument->createElement('media');
        $mediaNode->setAttribute('id', 0); // perhaps this is the ID of a media record our module has downloaded to the library
        $mediaNode->setAttribute('type', 'image');
        $mediaNode->setAttribute('render', 'native');

        // Create options
        $optionsNode = $regionNode->ownerDocument->createElement('options');

        // Images require a uri attribute pointing to the media stored as
        $optionNode = $regionNode->ownerDocument->createElement('uri', 0);
        $optionsNode->appendChild($optionNode);

        // Add our new node
        $mediaNode->appendChild($optionsNode);
        $regionNode->appendChild($mediaNode);

        $log->debug('Finish processing event');

        // We don't need to return anything here as we've been editing an object
    });
}
```



