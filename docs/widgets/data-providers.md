---
nav: "widgets"
slug: "widgets/data-providers"
title: "Creating a Module - Data Providers"
---

# Providing Data

If you are making a new module that has data then this data will need to be requested/parsed and made available to the widget. There are two ways to do this:

* Setting a Widget Provider in the `class` attribute. This is a good choice if your data source does not require any special authentication flows or complex configuration.
* Handling the `WidgetDataRequestEvent` using a connector or custom middleware. This is necessary when you have more complex requirements, such as authentication flows; or when you can supply more than once data type.

Xibo provides an instance of `DataProviderInterface` to both.

## The DataProvider Interface

Whether you're using a WidgetProvider or handling the `WidgetDataRequestEvent` event, you will interact with the `DataProviderInterface` to add data items, metadata and images to your data points.

The most basic usage of the data provider will be to call `addItem()` for each data point needed. These should be a `JsonSerializable` object or key/value array per item.

Retrieving and parsing data will likely depend on module settings and properties, which can be retrieved with `getSetting()` and `getProperty()`. A Guzzle HTTP client has been provided with `getGuzzleClient()`, preconfigured with any proxy settings.

If the request has been handled, you must call `setIsHandled()` on the data provider.

## Use the data provider
### Using a Widget Provider

To use a widget provider a new class should be created and added to the `class` attribute in the module XML. This class should implement `WidgetProviderInterface` and add logic to the `fetchData` method.

### Using a Connector

Create a new [connector](../extend/connectors) and register it with the dispatcher to handle the `WidgetDataRequestEvent`.

```php
public function registerWithDispatcher(EventDispatcherInterface $dispatcher): ConnectorInterface
{
    $dispatcher->addListener(WidgetDataRequestEvent::$NAME, [$this, 'onDataRequest']);
    return $this;
}
```

Inside the method which will handle the event (`onDataRequest` in the above example) the source of the event should be tested to ensure the event is for the correct datatype/module using `$event->getDataProvider()->getDataSource()`.

Note: is it also possible to handle the `WidgetDataRequestEvent` in a custom middleware, which can be useful if the user does not need to make configuration changes or otherwise see a connector in the user interface.


