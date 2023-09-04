---
nav: "extend"
slug: "extend/connectors"
title: "Connectors - Extend Xibo"
---

# Connectors

>  NOTE: The foundations for connectors have been implemented in v3.1 of Xibo and will be extended and documented as we move into Xibo v4.

Connectors allow developers to easily hook into the various events raised by Xibo's event system. In `v4` they will also be able to provide data for widgets. They are shown on the "Applications" page, and allow a user to enable/disable as well as provide settings such as API keys.

All custom connectors need a definition file to tell Xibo where the class file is located. These definition files are simple and should be placed in the `/custom` folder with a `.connector` extension. The file below is an example called `/custom/my-connector.connector`. The file name will be used as the ID of the file and should be unique to your connector.

```json
{
    "className": "\\Xibo\\Custom\\MyConnector"
}
```

Connectors then need the named class to implement the `\Xibo\Connector\ConnectorInterface`. A trait is provided for common functions.

Below is an example connector class file which registers a listener for the `maintenance.regular.event` and outputs a simple log line when that event occurs.

```php
<?php

namespace Xibo\Custom;

use Symfony\Component\EventDispatcher\EventDispatcherInterface;
use Xibo\Connector\ConnectorInterface;
use Xibo\Connector\ConnectorTrait;
use Xibo\Event\MaintenanceRegularEvent;
use Xibo\Support\Sanitizer\SanitizerInterface;

class MyConnector implements ConnectorInterface
{
    use ConnectorTrait;

    public function registerWithDispatcher(EventDispatcherInterface $dispatcher): ConnectorInterface
    {
        $dispatcher->addListener('maintenance.regular.event', [$this, 'onRegularMaintenance']);
        return $this;
    }

    public function getSourceName(): string
    {
        return 'my-connector';
    }

    public function getTitle(): string
    {
        return 'My Connector';
    }

    public function getDescription(): string
    {
        return 'This is my connector';
    }

    public function getThumbnail(): string
    {
        return '';
    }

    public function getSettingsFormTwig(): string
    {
        return '';
    }

    public function processSettingsForm(SanitizerInterface $params, array $settings): array
    {
        return $settings;
    }

    public function onRegularMaintenance(MaintenanceRegularEvent $event)
    {
        $this->getLogger()->debug('onRegularMaintenance: My connector!');
    }
}
```

