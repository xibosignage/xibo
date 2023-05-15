---
nav: "widgets"
slug: "widgets/creating-a-module"
alias: "modules-and-widgets"
title: "Creating a Module - Widgets"
---

# Creating a Module

"Module" is Xibo's name for the logic which sits behind a Widget. Users create widgets, developers create modules.

{tip}Xibo `v4` has extensive changes to the way widgets are modelled and developed. If you are thinking of making a widget, we **recommend** using `v4` as your starting point.{/tip}

### Modules and Templates
Xibo separates widget creation into two parts, the Module and then optionally the Template. All widgets must have a module, but only **widgets with data** will require a template. Templates can be reused across multiple modules, for example you may have multiple services providing social media data, all of which can be visualised by the same template.

 * Module: is a library file or produces some HTML generated when it is saved, and does not change (unless changed by JavaScript).
 * Template: is HTML/CSS/JavaScript applied to each item of data, and new data can be fed into the widget as it is playing.

Properties in the module will be shown on a "configure" tab in the Layout Editor, and properties in the template will be shown on an "appearance" tab.

Modules which are expected to supply data have the `dataType` property set. Xibo has some built in datatypes, such as article, social media, event, etc, but if these do not match the module it is possible to add new data types via XML.


## What do you want to create?

| I want to...                                                     | ...you need a                                                                                                                                                         |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Upload a media file to assign directly to a Display.             | Module XML file with `regionSpecific=0` and `assignable=0`.                                                                                                           |
| Upload a media file and tell Xibo how to show it.                | Module XML file with `regionSpecific=0` and `assignable=1`.                                                                                                           |
| Create some reusable/configurable HTML for Layouts.              | Module XML file with `regionSpecific=1` and `assignable=1`.                                                                                                           |
| Create a new way to visualise an existing Widget which has data. | Template XML file with a matching `dataType`.                                                                                                                         |
| Pull, parse and display data on a Layout.                        | Module XML file with `regionSpecific=1`, `assignable=1`, a `dataType` and maybe a `class` or Connector. You also need a Template XML file with a matching `dataType`. |


## Hello World...

It is useful to start with a simple example. Here it is, the obligatory [hello world example](hello-world.md).

## File locations

Xibo's module system uses XML and where necessary for data retrieval, PHP files.

These files are located in the following places:

| Type                | Location                                                 |
|---------------------|----------------------------------------------------------|
| Core module XML     | `/modules`                                               |
| Core template XML   | `/modules/templates`                                     |
| Core datatype XML   | `/modules/datatypes`                                     |
| Custom module XML   | `/custom/modules`                                        |
| Custom template XML | `/custom/modules/templates`                              |
| Custom datatype XML | `/custom/modules/datatypes`                              |
| Custom PHP          | `/custom` (Autoloaded from the `\Xibo\Custom` namespace) |

## 1. XML definitions

### 1.1. Module

| Element              | Type         | Description                                                                                                                                                                                                                                       | Options                      | Sample value        |
|----------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|---------------------|
| `id`                 | string       | A unique ID for the module. Core modules are prefixed with `core-`. If you want to distribute your module it would be sensible to give it a prefix personal to you.                                                                               |                              | `core-embedded`     |
| `name`               | string       | This is the friendly name of your module. It will be shown in the Layout Designer.                                                                                                                                                                |                              |                     |
| `author`             | string       | You :), only shown on the Module admin page.                                                                                                                                                                                                      |                              |                     |
| `description`        | string       | A description for the module, only used on the Module admin page.                                                                                                                                                                                 |                              |                     |
| `class`              | string       | The class name of a Widget Provider, if needed. Not all modules need this, see below.                                                                                                                                                             |                              |                     |
| `compatibilityClass` | string       | The class name of a Widget Compatibility Interface, if needed. Not all modules need this, see below.                                                                                                                                              |                              |                     |
| `type`               | string       | This is the internal identifier for your module and is what gets recorded on the Layout XLF file and sent to the Player. This does not have to be unique, the CMS will choose the first available module of a particular type to render a Widget. |                              |                     |
| `dataType`           | string       | If this module returns data, this is the data type of that data. It is also used to select the corresponding templates.                                                                                                                           |                              | `article`           |
| `dataCacheKey`       | string       | Cache key for a module that returns data. Use with module properties between `%` characters, and separate multiple properties with a `_`.                                                                                                         |                              | `%id%_%name%`       |
| `schemaVersion`      | integer      | Schema Version - can use used to determine different rendering from past versions.                                                                                                                                                                |                              | `1`                 |
| `assignable`         | integer      | Should this module be assignable - used for Library modules.                                                                                                                                                                                      | `0`, `1`                     | `1`                 |
| `regionSpecific`     | integer      | Is this Module for the Library (0) or a Widget on a Layout (1)                                                                                                                                                                                    | `0`, `1`                     | `1`                 |
| `renderAs`           | string       | Render natively (`native`) or as HTML (`html`). If you are making a Player that will understand how to render the module set to `native`. Native modules must provide a preview stencil.                                                          | `html`, `native`             | `html`              |
| `defaultDuration`    | integer      | When the user has declined to provide a duration for the Widget, what should the duration be.                                                                                                                                                     |                              | `60`                |
| `legacyType`         | LegacyType   | If this module is a legacy module, use to match with old version of the module.                                                                                                                                                                   |                              | `weather`           |
| `thumbnail`          | string       | The assetId of an image to be used as the thumbnail                                                                                                                                                                                               |                              |                     |
| `startWidth`         | integer      | The width of this widget when it is first added to a layout                                                                                                                                                                                       |                              | 500                 |
| `startHeight`        | integer      | The height of this widget when it is first added to a layout                                                                                                                                                                                      |                              | 500                 |
| `showIn`             | string       | Where should this module be shown?                                                                                                                                                                                                                | `both`, `playlist`, `layout` | `both`              |
| `settings`           | Property     | Settings shown on the Module admin page.                                                                                                                                                                                                          |                              |                     |
| `properties`         | Property     | Properties shown in the configuration panel of the Layout and Playlist editors.                                                                                                                                                                   |                              |                     |
| `preview`            | Stencil      | A stencil for previewing. If not set, `stencil` will be used.                                                                                                                                                                                     |                              |                     |
| `stencil`            | Stencil      | A stencil for the HTML to be sent to the Player                                                                                                                                                                                                   |                              |                     |
| `onInitialize`       | CDATA string | JavaScript function run when a module is initialised, before data is returned.                                                                                                                                                                    |                              | `<![CDATA[ ... ]]>` |
| `onParseData`        | CDATA string | JavaScript function running as data parser against each data item applicable when a `dataType` is present.                                                                                                                                        |                              | `<![CDATA[ ... ]]>` |
| `onRender`           | CDATA string | JavaScript function run when a module is rendered, after data has been returned.                                                                                                                                                                  |                              | `<![CDATA[ ... ]]>` |
| `onVisible`          | CDATA string | JavaScript function run right before a module is shown.                                                                                                                                                                                           |                              | `<![CDATA[ ... ]]>` |
| `sampleData`         | CDATA string | A JSON data item to use as a sample                                                                                                                                                                                                               |                              | `<![CDATA[ ... ]]>` |
| `assets`             | Asset        | A list of assets to be included in the module.                                                                                                                                                                                                    |                              |                     |

#### 1.1.1. Legacy Type

Legacy Type is used to indicate where a current module XML definition can serve an old/alternate module type. This is used on CMS upgrade or Layout import to convert a widget from its old state to a state compatible with this release.

| Element     | Type   | Description                                                               | Options | Sample value             |
|-------------|--------|---------------------------------------------------------------------------|---------|--------------------------|
| `name`      | string | The legacy type of the module to match against                            |         | `countdown`              |
| `condition` | string | An optional condition to match against the properties saved on the widget |         | `templateId==countdown3` |

For example, the `countdown` module from v2/v3 has been split into 4 separate countdown modules in v4, each one serving a different "templateId" in the v3 version of that module. Adding a legacy type definition to the new module means that it will match and convert an old widget into the new module.

### 1.2. Template

| Element            | Type         | Description                                                                            | Options                        | Sample value        |
|--------------------|--------------|----------------------------------------------------------------------------------------|--------------------------------|---------------------|
| `id`               | string       | A unique ID for the template.                                                          |                                | `template1`         |
| `type`             | string       | The type of template.                                                                  | `static`, `element`, `stencil` | `static`            |
| `title`            | string       | The title of the template used in the CMS to identify the template.                    |                                | `Template 1`        |
| `dataType`         | string       | The data type of the template. Used to list the template in the corresponding modules. |                                | `article`           |
| `thumbnail`        | string       | The assetId of an image to be used as the thumbnail                                    |                                |                     |
| `showIn`           | string       | Where should this module be shown?                                                     | `both`, `playlist`, `layout`   | `both`              |
| `properties`       | Property     | Same as the properties in the Module XML, but specific to the template.                |                                |                     |
| `stencil`          | Stencil      | The stencil for the HTML of the template.                                              |                                |                     |
| `onTemplateRender` | CDATA string | JavaScript function run when a template is rendered.                                   |                                | `<![CDATA[ ... ]]>` |

> **Note:** Template `id` cannot contain hyphens (`-`). This is because it will be used to generate a unique method name for `onTemplateRender`.

### 1.3. Property

Common structure for all properties.

| Attribute | Description                                          | Options                                   | Sample value |
|-----------|------------------------------------------------------|-------------------------------------------|--------------|
| `id`      | A unique ID for the property.                        |                                           | `showHeader` |
| `type`    | The type of property.                                | See [Property Types](#133-property-types) | `checkbox`   |

| Element               | Type                 | Description                                                                                                        | Options | Sample value          |
|-----------------------|----------------------|--------------------------------------------------------------------------------------------------------------------|---------|-----------------------|
| `title`               | string               | Used in the CMS to identify the property in the module configuration form.                                         |         | Header                |
| `helpText`            | string               | Help text to be displayed in the module configuration form.                                                        |         | Show header on table? |
| `default`             | string               | The default value for the property.                                                                                |         | `1`                   |
| `visibility`          | Visibility           | Set the visibility of the property based a set of rules.                                                           |         |                       |
| `validation`          | Validation           | Validation rules for the property when submitted.                                                                  |         |                       |
| `playerCompatibility` | Player Compatibility | Create a input helper to show the property compatibility with the players.                                         |         |                       |
| `dependsOn`           | string               | ID of the property that this property depends on. Used to update the property when the target property is changed. |         | `showHeader`          |

#### 1.3.1. Visibility

| Element | Description      |
|---------|------------------|
| `test`  | Visibility test. |

##### Visibility Test

| Attribute | Description | Options     | Sample value |
|-----------|-------------|-------------|--------------|
| `type`    | Test type.  | `and`, `or` | `and`        |

| Element     | Type      | Description                |
|-------------|-----------|----------------------------|
| `condition` | Condition | Visibility test condition. |

##### Visibility Test - Condition

| Attribute | Type           | Description                         | Options                               | Sample value |
|-----------|----------------|-------------------------------------|---------------------------------------|--------------|
| `field`   | string         | Id of the property to test against. |                                       | `showHeader` |
| `type`    | Condition Type | Type of condition test.             | `eq`, `neq`, `gt`, `egt`, `lt`, `elt` | `eq`         |

| Element   | Description                 |
|-----------|-----------------------------|
| nodeValue | Value to be tested against. |

##### Condition Type

| Name  | Description              |
|-------|--------------------------|
| `eq`  | Equal to                 |
| `neq` | Not equal to             |
| `gt`  | Greater than             |
| `egt` | Greater than or equal to |
| `lt`  | Less than                |
| `elt` | Less than or equal to    |

#### 1.3.2. Player Compatibility

| Attribute | Description             |
|-----------|-------------------------|
| `windows` | Windows player version. |
| `linux`   | Linux player version.   |
| `android` | Android player version. |
| `webos`   | WebOS player version.   |
| `tizen`   | Tizen player version.   |

#### 1.3.3. Property Types

All properties have the options listed in the [Property](#13-property) section. They can be of the following types:

| Name                    | Description                                           |
|-------------------------|-------------------------------------------------------|
| `text`                  | Text input                                            |
| `number`                | Number input                                          |
| `checkbox`              | Checkbox                                              |
| `dropdown`              | Dropdown                                              |
| `color`                 | Color picker                                          |
| `code`                  | Code editor                                           |
| `richText`              | Rich text editor                                      |
| `date`                  | Date picker                                           |
| `hidden`                | Hidden input                                          |
| `fontSelector`          | Font selector                                         |
| `datasetSelector`       | Dataset selector                                      |
| `datasetOrder`          | Dataset order                                         |
| `datasetFilter`         | Dataset filter                                        |
| `datasetColumnSelector` | Dataset column selector                               |
| `header`                | Header                                                |
| `message`               | Message                                               |
| `divider`               | Divider                                               |
| `connectorProperties`   | A dropdown/search filled with values from a connector |

#### 1.3.4. Property Additional Options

These properties have additional options.

##### Dropdown

| Attribute  | Type    | Type Description                                     | Options           | Sample value |
|------------|---------|------------------------------------------------------|-------------------|--------------|
| `multiple` | integer | Allow multiple selections.                           | `0`, `1`          | `0`          |
| `mode`     | string  | For a dropdown, should it be single or multi-select. | `single`, `multi` | `single`     |

| Element        | Type   | Description               | Options | Sample value |
|----------------|--------|---------------------------|---------|--------------|
| `options`      | Option | Options for the dropdown. |         |              |
| `optionsTitle` | string | Title of the options.     |         | `newTitle`   |
| `optionsValue` | string | Value of the options.     |         | `newValue`   |

##### Option

| Attribute | Type   | Type Description    | Options | Sample value |
|-----------|--------|---------------------|---------|--------------|
| `name`    | string | Name of the option. |         | `newOption`  |

| Element   | Type   | Description          | Options | Sample value |
|-----------|--------|----------------------|---------|--------------|
| nodeValue | string | Value of the option. |         | `newOption`  |

##### Code

| Attribute           | Type   | Description                                     | Options                     | Sample value |
|---------------------|--------|-------------------------------------------------|-----------------------------|--------------|
| `variant`           | string | Code editor variant.                            | `html`, `css`, `javascript` | `javascript` |
| `allowLibraryRefs`  | bool   | Allow library references.                       | `true`, `false`             | `false`      |
| `allowAssetRefs`    | bool   | Allow asset references.                         | `true`, `false`             | `false`      |
| `parseTranslations` | bool   | Parse the value for translations between pipes. | `true`, `false`             | `false`      |

##### Rich Text

| Attribute           | Type | Description                                     | Options         | Sample value |
|---------------------|------|-------------------------------------------------|-----------------|--------------|
| `allowLibraryRefs`  | bool | Allow library references.                       | `true`, `false` | `false`      |
| `allowAssetRefs`    | bool | Allow asset references.                         | `true`, `false` | `false`      |
| `parseTranslations` | bool | Parse the value for translations between pipes. | `true`, `false` | `false`      |

##### Date

| Attribute | Type   | Description   | Options                             | Sample value |
|-----------|--------|---------------|-------------------------------------|--------------|
| `format`  | string | Date format.  |                                     | `YYYY-MM-DD` |
| `variant` | string | Date variant. | `date`, `time`, `datetime`, `month` | `date`       |

##### Connector Properties

A dropdown/search field which returns a set of options/values from a connector which handles the request.

### 1.4. Stencil

| Element | Type         | Description                         | Sample value                                                               |
|---------|--------------|-------------------------------------|----------------------------------------------------------------------------|
| twig    | CDATA string | Twig template                       | `<![CDATA[ <p>Some HTML</p><style> .some-css { color: red; } </style> ]]>` |
| hbs     | CDATA string | Handlebars template                 | `<![CDATA[ <p>{{someValue}}</p> ]]>`                                       |
| width   | integer      | Width of the template to be scaled  | 600                                                                        |
| height  | integer      | Height of the template to be scaled | 400                                                                        |

#### 1.4.1. Twig

Twig will be rendered directly into the module HTML. It can be used to add custom CSS or HTML to the module.

It needs to be provides as a CDATA block, to prevent the XML parser from interpreting the HTML.

By setting a `width` and `height` attribute, the template will be scaled to match those dimensions in the player.

#### 1.4.2. Handlebars (hbs)

When set in the template, the `hbs` node value will be used as a template for each item provided.

If it's defined in the module, it will be used as a template for the module itself.

We can use `{{ }}` with module or item properties, data can be rendered to the template.

### 1.5. Sample data

When developing a module with a data provider, it's important to have a sample data to test the rendering.
The sample data can be provided as a JSON string, in the `sampleData` node.

Data can be provided as a single item:

```xml
<sampleData><![CDATA[
{
    "id": "1",
    "name": "One",
    "description": "This is the first item",
    "value": "1"
}
]]></sampleData>
```

Or as an array of items:

```xml
<sampleData><![CDATA[
[
    {
        "id": "1",
        "name": "One",
        "description": "This is the first item",
        "value": "1"
    },
    {
        "id": "2",
        "name": "Two",
        "description": "This is the second item",
        "value": "2"
    },
    {
        "id": "3",
        "name": "Three",
        "description": "This is the third item",
        "value": "3"
    }
]
]]></sampleData>
```

### 1.6. Assets
When assets are required for the module, they can be added to the `assets` node.

| Element | Type  | Description                       |
|---------|-------|-----------------------------------|
| asset   | Asset | A file to be added to the module. |

#### Asset

| Attribute | Type    | Description                         | Options | Sample value                |
|-----------|---------|-------------------------------------|---------|-----------------------------|
| `id`      | string  | ID of the asset.                    |         | `newImage`                  |
| `type`    | string  | Type of the asset.                  | `path`  | `path`                      |
| `mime`    | string  | Mime type of the asset.             |         | `image/png`                 |
| `path`    | string  | Path to the asset.                  |         | `/modules/assets/image.png` |
| `cmsOnly` | boolean | Is this asset only used in the CMS? |         | true                        |

And then the asset can be referenced in the module with the `[[assetId=newImage]]` syntax.

### 1.7. Data Type
Each `datatype.xml` file should have a top level node called `<dataTypes>`, inside which is each `<dataType>` node.

| Element  | Type     | Description                      | Options | Sample value |
|----------|----------|----------------------------------|---------|--------------|
| `id`     | string   | A unique ID for the datatype.    |         | `currency`   |
| `name`   | string   | A friendly name for the datatype |         | Currency     |
| `fields` | Fields[] | A array of fields                |         |              |

#### 1.7.1. Field
| Element | Type   | Description             | Options | Sample value                           |
|---------|--------|-------------------------|---------|----------------------------------------|
| `title` | string | The title of this field |         | The time this quote was last refreshed |

#### 1.7.1. Field Attributes
| Attribute | Type   | Description                                   | Sample value                  |
|-----------|--------|-----------------------------------------------|-------------------------------|
| `id`      | string | A unique ID for this field (used in widgets)  | time                          | 
| `type`    | string | The data type this field should be treated as | number, text, datetime, image | 


## 2. Saving, previewing and generating HTML

### 2.2. Properties
Properties declared in either the module or template XML will be shown on the widget edit form in the Layout Editor and saved with the Widget.

These properties will be made available when rendering a stencil from Twig or Handlebars.

### 2.3. Generating HTML
Each time the widget is saved, the module and template XML stencils will be used to generate and cache the Widget HTML, which will subsequently be sent to players as necessary. HBS content in the stencils will be rendered at playtime.

### 2.4. Working with Data
Modules with data will need to supply a `dataType` property and should ensure that this is unique to the CMS. There are two ways to provide data for a `dataType`, see "Providing Data" below.

### 2.5. Previewing
A module has the opportunity to provide an alternative preview using the `preview` option. If this is not provided the full HTML will be shown instead.

## 3. Render flow

### 3.1. How it works

The rendering flow of a module is how the content is created, based on the data that is passed in to the module. All modules are optional, and run in sequence.

The `onInitialize` method is the first to run, and is mostly used to set up the variables and methods that will be used in the rendering process.

This is followed by the `onParseData` method, which is used to parse and transform the data for each item that comes from the provider.

Next the rendering method `onRender` and `onTemplateRender` run in sequence. The `onRender` method is used to render the HTML for the module, and the `onTemplateRender` method is used to render the HTML for the template. If they are not present, a default render method is used to render and scale the module appropriately.

Finally, the `onVisible` method is used to start any animations that may be required.

### 3.2. Methods

#### `onInitialize`, `onRender`, `onVisible`

Called on the module.

| Name         | Description                            |
|--------------|----------------------------------------|
| `id`         | The id of the widget                   |
| `target`     | The module HTML container              |
| `items`      | The data items                         |
| `properties` | The properties of the module           |
| `meta`       | The meta data provided by the provider |

#### `onParseData`

Called on each module item.

| Name         | Description                            |
|--------------|----------------------------------------|
| `item`       | The data item                          |
| `properties` | The properties of the module           |
| `meta`       | The meta data provided by the provider |

#### `onTemplateRender`

Called on the template.

| Name         | Description                            |
|--------------|----------------------------------------|
| `id`         | The id of the widget                   |
| `target`     | The module HTML container              |
| `items`      | The data items                         |
| `properties` | The properties of the module           |
| `meta`       | The meta data provided by the provider |

> **Note:** Both `onRender` and `onTemplateRender` are called multiple times when changing the dimensions of the preview window. If set, the methods needs to be able to clear the previous render in each call.

## 4. Replacements

In the module `hbs` template, with [handlebar expressions](https://handlebarsjs.com/guide/#what-is-handlebars) we can use module properties and data item properties to render and structure the content.

```xml
<hbs><![CDATA[
<h1>{{name}}</h1>
{{#eq showAge 1}}
    <p>Age: {{age}}</p>
{{/eq}}
]]></hbs>
```

In the `twig` template, we can also use variables and expression from the [Twig template engine](https://twig.symfony.com/doc/2.x/templates.html) to render the content.

```xml
<twig><![CDATA[
<style>
    .name {
        font-size: {{fontSize}}px;
    }
{% if showAge != 1 %}
    .age {
        display: none;
    }
{% endif %}
]]></twig>
```

## 5. Using the Xibo Interactive Control

[Xibo Interactive Control](https://github.com/xibosignage/xibo-interactive-control) is a JavaScript helper library used primarily to send actions from Widgets running in Xibo's built in Web Browser, to the Player application itself on its local web server.

But that tool can also be used to store and retrieve data during the execution of a Widget. That means we can store data in a rendering method and retrieve it in another one.

### 5.1. Store data

To store data, we can use the `xiboIC` object, which is available globally in the `window` object.

Store variable:

```javascript
xiboIC.set('myData', 'Hello World');
```

Store method:

```javascript
xiboIC.set('myMethod', function() {
    return 'Hello World';
});
```

### 5.2. Retrieve data

In a different method, we can then retrieve the data using the `xiboIC` object.

Retrieve variable:

```javascript
var myData = xiboIC.get('myData');
console.log(myData);
```

Retrieve method:

```javascript
var myMethod = xiboIC.get('myMethod');
console.log(myMethod());
```

## 6. Providing Data
If you are making a new module that has data then this data will need to be requested/parsed and made available to the widget. There are two ways to do this:

 * Setting a Widget Provider in the `class` attribute.
 * Handling the `WidgetDataRequestEvent`. 

Xibo provides an instance of `DataProviderInterface` to both options so that data can be provided.

### 6.1. Using a Widget Provider
To use a widget provider a new class should be created and added to the `class` attribute in the module XML. This class should implement `WidgetProviderInterface` and add logic to the `fetchData` method.

### 6.2. Using a Connector
Create a new connector and register it with the dispatcher to handle the `WidgetDataRequestEvent`.

```php
public function registerWithDispatcher(EventDispatcherInterface $dispatcher): ConnectorInterface
{
    $dispatcher->addListener(WidgetDataRequestEvent::$NAME, [$this, 'onDataRequest']);
    return $this;
}
```

Inside the method which will handle the event (`onDataRequest` in the above example) the source of the event should be tested to ensure the event is for the correct datatype/module using `$event->getDataProvider()->getDataSource()`.

Note: is it also possible to handle the `WidgetDataRequestEvent` in a custom middleware, which can be useful if the user does not need to make configuration changes or otherwise see a connector in the user interface.

### 6.3. The DataProvider Interface
Whether you're using a WidgetProvider or handling the `WidgetDataRequestEvent` event, you will interact with the `DataProviderInterface` to add data items, metadata and images to your data points.

The most basic usage of the data provider will be to call `addItem()` for each data point needed. These should be a `JsonSerializable` object or key/value array per item.

Retrieving and parsing data will likely depend on module settings and properties, which can be retrieved with `getSetting()` and `getProperty()`. A Guzzle HTTP client has been provided with `getGuzzleClient()`, preconfigured with any proxy settings.
