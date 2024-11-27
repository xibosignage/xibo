---
nav: "widgets"
slug: "widgets/hello-world"
alias: "modules-and-widgets"
title: "Hello World - Widgets"
excerpt: "This is a super simple example of Xibo’s module system in action. If you copy this code into your Xibo v4 CMS installation, you will be able to add a simple message to your Layouts."
---

# Examples

## Hello world - no data
This is a super simple example of Xibo's module system in action. If you copy this code into your Xibo v4 CMS installation, you will be able to add a simple message to your Layouts.

{tip}The example is trivial on purpose! 😀️{/tip}

### Module XML
This file should be saved in `custom/modules/xibosignage-helloworld.xml`

```xml
<module>
    <id>xibosignage-helloworld</id>
    <name>Hello World</name>
    <author>Xibo Signage</author>
    <description>Here it is, the obligatory Hello World example</description>
    <class></class>
    <type>helloworld</type>
    <dataType></dataType>
    <schemaVersion>1</schemaVersion>
    <assignable>1</assignable>
    <regionSpecific>1</regionSpecific>
    <renderAs>html</renderAs>
    <defaultDuration>60</defaultDuration>
    <settings></settings>
    <properties>
        <property id="message" type="input">
            <title>What is your message?</title>
            <helpText>Enter your message</helpText>
        </property>
    </properties>
    <preview></preview>
    <stencil>
        <twig><![CDATA[
<h1>Your message is.....</h1>
<p>{{message}}</p>
        ]]></twig>
    </stencil>
    <onRender><![CDATA[
// Scale the element every time
$(target).xiboLayoutScaler(properties);
    ]]></onRender>
</module>
```

We use a Twig template to get our saved `message` property and output it in the HTML that the player receives. We also use our `onRender` JavaScript function to call the `xiboLayoutScaler` for handling [widget size](widget-sizing).


## Hello world - with data
In this example we're going to add a new widget which provides data for the existing message data type. You can see from the data type definition that message has a simple structure:

```xml
<datatype>
    <id>message</id>
    <name>Message</name>
    <fields>
        <field id="subject" type="string">
            <title>The message subject</title>
        </field>
        <field id="body" type="string">
            <title>The message body</title>
        </field>
        <field id="date" type="datetime">
            <title>The release date of this message</title>
        </field>
        <field id="createdAt" type="datetime">
            <title>The created date of this message</title>
        </field>
    </fields>
</datatype>
```

### Module XML
This file should be saved in `custom/modules/xibosignage-helloworld-data.xml`. In the below definition we've said that the dataType is "message", and we've defined a "HelloWorldDataProvider" to supply that data.

```xml
<module>
    <id>xibosignage-helloworld-data</id>
    <name>Hello World - with Data</name>
    <author>Xibo Signage</author>
    <description>Here it is, the obligatory Hello World example, with data</description>
    <class>\Xibo\Custom\Example\HelloWorldDataProvider</class>
    <type>helloworld-data</type>
    <dataType>message</dataType>
    <schemaVersion>1</schemaVersion>
    <assignable>1</assignable>
    <regionSpecific>1</regionSpecific>
    <renderAs>html</renderAs>
    <defaultDuration>60</defaultDuration>
    <settings></settings>
    <properties></properties>
    <preview></preview>
</module>
```

This file should be saved in `custom/HelloWorldDataProvider.php`

```php
<?php
namespace Xibo\Custom\Example;

use Carbon\Carbon;
use Xibo\Widget\Provider\DataProviderInterface;
use Xibo\Widget\Provider\DurationProviderInterface;
use Xibo\Widget\Provider\WidgetProviderInterface;
use Xibo\Widget\Provider\WidgetProviderTrait;

class HelloWorldDataProvider implements WidgetProviderInterface
{
    use WidgetProviderTrait;

    public function fetchData(DataProviderInterface $dataProvider): WidgetProviderInterface
    {
        // In here we would normally go out and fetch our data from somewhere, probably using the
        // $dataProvider->getGuzzleClient() to make a request.
        // For this example, we will return some data.
        $dataProvider->addItem([
            'subject' => 'My made up subject',
            'body' => 'My message body',
            'date' => Carbon::now()->subDays(2),
            'createdAt' => Carbon::now()->subDays(5),
        ]);
        $dataProvider->setIsHandled();
        return $this;
    }

    public function fetchDuration(DurationProviderInterface $durationProvider): WidgetProviderInterface
    {
        return $this;
    }

    public function getDataCacheKey(DataProviderInterface $dataProvider): ?string
    {
        return null;
    }

    public function getDataModifiedDt(DataProviderInterface $dataProvider): ?Carbon
    {
        return null;
    }
}
```

When we add our new module to a layout, we will see that the existing templates for the `message` data type are available to the user.

{tip}We can do the reverse and create a template for an existing data type. This template would be available under any module that uses it.{/tip} 

# Use the module
## Enabling the Modules
Modules can be enabled in the CMS. Open your CMS and navigate to the Administration -> Modules page, find your module in the list and click Edit. Check enabled and save.

## Add to a Layout
Open your CMS and navigate to the Design -> Layouts page, click Add Layout and open the widget section of the toolbox in the Layout Editor. Your new "Hello World" widget will be available and can be drag/dropped onto your layout.

# Templates
You can implement a new template for any existing data type; your template will appear as an option for any module which is for that data type.
