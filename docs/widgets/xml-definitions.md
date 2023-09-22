---
nav: "widgets"
slug: "widgets/xml-definitions"
title: "Creating a Module - XML definitions"
---

# XML definitions

Section 1 contains XML definitions for the module and template XML files.

## 1. Module

| Element              | Type         | Description                                                                                                                                                                                                                                       | Options                                                                                              | Sample value        |
|----------------------|--------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|---------------------|
| `id`                 | string       | A unique ID for the module. Core modules are prefixed with `core-`. If you want to distribute your module it would be sensible to give it a prefix personal to you.                                                                               |                                                                                                      | `core-embedded`     |
| `name`               | string       | This is the friendly name of your module. It will be shown in the Layout Designer.                                                                                                                                                                |                                                                                                      |                     |
| `author`             | string       | You :), only shown on the Module admin page.                                                                                                                                                                                                      |                                                                                                      |                     |
| `description`        | string       | A description for the module, only used on the Module admin page.                                                                                                                                                                                 |                                                                                                      |                     |
| `class`              | string       | The class name of a Widget Provider, if needed. Not all modules need this, see below.                                                                                                                                                             |                                                                                                      |                     |
| `compatibilityClass` | string       | The class name of a Widget Compatibility Interface, if needed. Not all modules need this, see below.                                                                                                                                              |                                                                                                      |                     |
| `type`               | string       | This is the internal identifier for your module and is what gets recorded on the Layout XLF file and sent to the Player. This does not have to be unique, the CMS will choose the first available module of a particular type to render a Widget. |                                                                                                      |                     |
| `dataType`           | string       | If this module returns data, this is the data type of that data. It is also used to select the corresponding templates.                                                                                                                           |                                                                                                      | `article`           |
| `dataCacheKey`       | string       | Cache key for a module that returns data. Use with module properties between `%` characters, and separate multiple properties with a `_`.                                                                                                         |                                                                                                      | `%id%_%name%`       |
| `schemaVersion`      | integer      | Schema Version - can use used to determine different rendering from past versions.                                                                                                                                                                |                                                                                                      | `1`                 |
| `assignable`         | integer      | Should this module be assignable - used for Library modules.                                                                                                                                                                                      | `0`, `1`                                                                                             | `1`                 |
| `regionSpecific`     | integer      | Is this Module for the Library (0) or a Widget on a Layout (1)                                                                                                                                                                                    | `0`, `1`                                                                                             | `1`                 |
| `renderAs`           | string       | Render natively (`native`) or as HTML (`html`). If you are making a Player that will understand how to render the module set to `native`. Native modules must provide a preview stencil.                                                          | `html`, `native`                                                                                     | `html`              |
| `defaultDuration`    | integer      | When the user has declined to provide a duration for the Widget, what should the duration be.                                                                                                                                                     |                                                                                                      | `60`                |
| `legacyType`         | LegacyType   | If this module is a legacy module, use to match with old version of the module.                                                                                                                                                                   |                                                                                                      | `weather`           |
| `thumbnail`          | string       | The assetId of an image to be used as the thumbnail                                                                                                                                                                                               |                                                                                                      |                     |
| `icon`               | string       | The class ID of an icon to show in the toolbar. Currently font awesome is supported. Used when a thumbnail is not provided.                                                                                                                       |                                                                                                      | `fa fa-font`        |
| `startWidth`         | integer      | The width of this widget when it is first added to a layout                                                                                                                                                                                       |                                                                                                      | 500                 |
| `startHeight`        | integer      | The height of this widget when it is first added to a layout                                                                                                                                                                                      |                                                                                                      | 500                 |
| `showIn`             | string       | Where should this module be shown?                                                                                                                                                                                                                | `both`, `playlist`, `layout`                                                                         | `both`              |
| `settings`           | Property     | Settings shown on the Module admin page.                                                                                                                                                                                                          |                                                                                                      |                     |
| `properties`         | Property     | Properties shown in the configuration panel of the Layout and Playlist editors.                                                                                                                                                                   |                                                                                                      |                     |
| `preview`            | Stencil      | A stencil for previewing. If not set, `stencil` will be used.                                                                                                                                                                                     |                                                                                                      |                     |
| `stencil`            | Stencil      | A stencil for the HTML to be sent to the Player                                                                                                                                                                                                   |                                                                                                      |                     |
| `onInitialize`       | CDATA string | JavaScript function run when a module is initialised, before data is returned.                                                                                                                                                                    |                                                                                                      | `<![CDATA[ ... ]]>` |
| `onDataLoad`         | CDATA string | JavaScript function run when a module retrieves data and before it renders it.                                                                                                                                                                    | // items: The items to render<br/>// meta: Metadata<br/>// properties: The properties for the widget | `<![CDATA[ ... ]]>` |
| `onDataError`        | CDATA string | JavaScript function run when a module fails to receive data.                                                                                                                                                                                      | // httpStatus: The HTTP status code of the request<br/>// response: the response body                |                     |
| `onParseData`        | CDATA string | JavaScript function running as data parser against each data item applicable when a `dataType` is present.                                                                                                                                        |                                                                                                      | `<![CDATA[ ... ]]>` |
| `onRender`           | CDATA string | JavaScript function run when a module is rendered, after data has been returned.                                                                                                                                                                  |                                                                                                      | `<![CDATA[ ... ]]>` |
| `onVisible`          | CDATA string | JavaScript function run right before a module is shown.                                                                                                                                                                                           |                                                                                                      | `<![CDATA[ ... ]]>` |
| `sampleData`         | CDATA string | A JSON data item to use as a sample                                                                                                                                                                                                               |                                                                                                      | `<![CDATA[ ... ]]>` |
| `assets`             | Asset        | A list of assets to be included in the module.                                                                                                                                                                                                    |                                                                                                      |                     |

### 1.1. Legacy Type

Legacy Type is used to indicate where a current module XML definition can serve an old/alternate module type. This is used on CMS upgrade or Layout import to convert a widget from its old state to a state compatible with this release.

| Element     | Type   | Description                                                               | Options | Sample value             |
|-------------|--------|---------------------------------------------------------------------------|---------|--------------------------|
| `name`      | string | The legacy type of the module to match against                            |         | `countdown`              |
| `condition` | string | An optional condition to match against the properties saved on the widget |         | `templateId==countdown3` |

For example, the `countdown` module from v2/v3 has been split into 4 separate countdown modules in v4, each one serving a different "templateId" in the v3 version of that module. Adding a legacy type definition to the new module means that it will match and convert an old widget into the new module.

## 2. Template

| Element              | Type         | Description                                                                            | Options                                                              | Sample value        |
|----------------------|--------------|----------------------------------------------------------------------------------------|----------------------------------------------------------------------|---------------------|
| `id`                 | string       | A unique ID for the template.                                                          |                                                                      | `template1`         |
| `type`               | string       | The type of template.                                                                  | `static`, `element`, `element-group`                                 | `static`            |
| `title`              | string       | The title of the template used in the CMS to identify the template.                    |                                                                      | `Template 1`        |
| `dataType`           | string       | The data type of the template. Used to list the template in the corresponding modules. |                                                                      | `article`           |
| `thumbnail`          | string       | The assetId of an image to be used as the thumbnail                                    |                                                                      |                     |
| `showIn`             | string       | Where should this module be shown?                                                     | `both`, `playlist`, `layout`                                         | `both`              |
| `properties`         | Property     | Same as the properties in the Module XML, but specific to the template.                |                                                                      |                     |
| `stencil`            | Stencil      | The stencil for the HTML of the template.                                              |                                                                      |                     |
| `onElementParseData` | CDATA string | JavaScript function run for each data property, before rendering.                      | // value: The value<br/>// properties: The properties for the widget |                     |
| `onTemplateRender`   | CDATA string | JavaScript function run when a template is rendered.                                   |                                                                      | `<![CDATA[ ... ]]>` |

> **Note:** Template `id` cannot contain hyphens (`-`). This is because it will be used to generate a unique method name for `onTemplateRender`.

## 3. Property

Common structure for all properties.

| Attribute | Description                   | Options                                   | Sample value |
|-----------|-------------------------------|-------------------------------------------|--------------|
| `id`      | A unique ID for the property. |                                           | `showHeader` |
| `type`    | The type of property.         | See [Property Types](#133-property-types) | `checkbox`   |

| Element               | Type                 | Description                                                                                                        | Options | Sample value          |
|-----------------------|----------------------|--------------------------------------------------------------------------------------------------------------------|---------|-----------------------|
| `title`               | string               | Used in the CMS to identify the property in the module configuration form.                                         |         | Header                |
| `helpText`            | string               | Help text to be displayed in the module configuration form.                                                        |         | Show header on table? |
| `default`             | string               | The default value for the property.                                                                                |         | `1`                   |
| `visibility`          | Rule                 | Set the visibility of the property based a set of rules.                                                           |         |                       |
| `validation`          | Rule                 | Set validation rules for the property when submitted and when status on the layout is reported.                    |         |                       |
| `playerCompatibility` | Player Compatibility | Create a input helper to show the property compatibility with the players.                                         |         |                       |
| `dependsOn`           | string               | ID of the property that this property depends on. Used to update the property when the target property is changed. |         | `showHeader`          |

### 3.1. Rule

Rules can be used for visibility and validation of properties. Rules consist of an array of tests which are evaluated individually (they are ANDed).

| Element    | Type    | Description                                                                                                      | Options | Default Value |
|------------|---------|------------------------------------------------------------------------------------------------------------------|---------|---------------|
| `onSave`   | boolean | Validation only: should the rule be applied when a property is saved?                                            |         | true          |
| `onStatus` | boolean | Validation only: should the rule be applied when the widget status is assessed                                   |         | true          |
| `message`  | string  | A string message to raise as an error, if empty a default message will be raised for the failing test/condition. |         |               |
| `test`     | Test[]  | One or more tests to apply.                                                                                      |         |               |

#### 3.1.1. Test

A test is a set of conditions which are assessed in sequence.

| Attribute | Description | Options     | Sample value |
|-----------|-------------|-------------|--------------|
| `type`    | Test type.  | `and`, `or` | `and`        |

| Element     | Type      | Description     |
|-------------|-----------|-----------------|
| `condition` | Condition | Test condition. |

#### 3.1.2. Condition

| Attribute | Type           | Description             | Options                                                                                                     | Sample value |
|-----------|----------------|-------------------------|-------------------------------------------------------------------------------------------------------------|--------------|
| `field`   | string         | null                    | Id of the property to test against (required for visibility) / get the value from (optional for validation) |              |
| `type`    | Condition Type | Type of condition test. | See condition type                                                                                          | `eq`         |

| Element   | Description                                                                            |
|-----------|----------------------------------------------------------------------------------------|
| nodeValue | Value to be tested against. (validation rules: leave empty for current property value) |

Rules used as validation always test the current property value against the value resolved by the condition. Rules used as visibility tests always test the value in the `field` attribute against the value in the node.

For rules used as validation this means that when a field name is provided it is the value of that field which is used to test **against** the current property value. For example:

A rule which ensures that the current property value is required and is of type uri.

```xml
<rule>
    <test type="and">
        <condition type="required"></condition>
        <condition type="uri"></condition>
    </test>
</rule>
```

A rule which ensures that the current property value is less than or equal to the duration.

```xml
<rule message="Warning duration needs to be lower than the widget duration.">
    <test type="and">
        <condition field="duration" type="lte"></condition>
    </test>
</rule>
```

Rules which need a comparison value such as `gt` must either have a field to get the comparison value from, or a value in the condition.

```xml
<rule message="Warning duration needs to be lower than 10">
    <test type="and">
        <condition type="lt">10</condition>
    </test>
</rule>
```

When using `or` tests, all conditions must fail for the test to fail.

#### Condition Type

| Name        | Description                   |
|-------------|-------------------------------|
| `required`  | Must have a value             |
| `eq`        | Equal to                      |
| `neq`       | Not equal to                  |
| `gt`        | Greater than                  |
| `gte`       | Greater than or equal to      |
| `lt`        | Less than                     |
| `lte`       | Less than or equal to         |
| `contains`  | Value contains                |
| `ncontains` | Value does not contain        |
| `uri`       | Must be a URI                 |
| `interval`  | Must be a valid date interval |

#### Default values

If the property defines a default value, this value is also tested against the rules and conditions defined on the property.

### 3.2. Player Compatibility

| Attribute | Description             |
|-----------|-------------------------|
| `windows` | Windows player version. |
| `linux`   | Linux player version.   |
| `android` | Android player version. |
| `webos`   | WebOS player version.   |
| `tizen`   | Tizen player version.   |

### 3.3. Property Types

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
| `datasetField`          | Dataset field selector (requires hidden `dataTypeId`) |
| `header`                | Header                                                |
| `message`               | Message                                               |
| `divider`               | Divider                                               |
| `connectorProperties`   | A dropdown/search filled with values from a connector |

### 3.4. Property Additional Options

These properties have additional options.

#### Dropdown

| Attribute  | Type    | Type Description                                     | Options           | Sample value |
|------------|---------|------------------------------------------------------|-------------------|--------------|
| `multiple` | integer | Allow multiple selections.                           | `0`, `1`          | `0`          |
| `mode`     | string  | For a dropdown, should it be single or multi-select. | `single`, `multi` | `single`     |

| Element        | Type   | Description               | Options | Sample value |
|----------------|--------|---------------------------|---------|--------------|
| `options`      | Option | Options for the dropdown. |         |              |
| `optionsTitle` | string | Title of the options.     |         | `newTitle`   |
| `optionsValue` | string | Value of the options.     |         | `newValue`   |

#### Option

| Attribute | Type   | Type Description    | Options | Sample value |
|-----------|--------|---------------------|---------|--------------|
| `name`    | string | Name of the option. |         | `newOption`  |

| Element   | Type   | Description          | Options | Sample value |
|-----------|--------|----------------------|---------|--------------|
| nodeValue | string | Value of the option. |         | `newOption`  |

#### Code

| Attribute           | Type   | Description                                     | Options                     | Sample value |
|---------------------|--------|-------------------------------------------------|-----------------------------|--------------|
| `variant`           | string | Code editor variant.                            | `html`, `css`, `javascript` | `javascript` |
| `allowLibraryRefs`  | bool   | Allow library references.                       | `true`, `false`             | `false`      |
| `allowAssetRefs`    | bool   | Allow asset references.                         | `true`, `false`             | `false`      |
| `parseTranslations` | bool   | Parse the value for translations between pipes. | `true`, `false`             | `false`      |

#### Rich Text

| Attribute           | Type | Description                                     | Options         | Sample value |
|---------------------|------|-------------------------------------------------|-----------------|--------------|
| `allowLibraryRefs`  | bool | Allow library references.                       | `true`, `false` | `false`      |
| `allowAssetRefs`    | bool | Allow asset references.                         | `true`, `false` | `false`      |
| `parseTranslations` | bool | Parse the value for translations between pipes. | `true`, `false` | `false`      |

#### Date

| Attribute | Type   | Description   | Options                             | Sample value |
|-----------|--------|---------------|-------------------------------------|--------------|
| `format`  | string | Date format.  |                                     | `YYYY-MM-DD` |
| `variant` | string | Date variant. | `date`, `time`, `datetime`, `month` | `date`       |

#### Connector Properties

A dropdown/search field which returns a set of options/values from a connector which handles the request.

| Attribute | Type   | Description | Options                    | Sample value |
|-----------|--------|-------------|----------------------------|--------------|
| `variant` | string | Variant.    | `autocomplete`, `dropdown` | `dropdown`   |

## 4. Stencil

| Element | Type         | Description                         | Sample value                                                               |
|---------|--------------|-------------------------------------|----------------------------------------------------------------------------|
| twig    | CDATA string | Twig template                       | `<![CDATA[ <p>Some HTML</p><style> .some-css { color: red; } </style> ]]>` |
| hbs     | CDATA string | Handlebars template                 | `<![CDATA[ <p>{{someValue}}</p> ]]>`                                       |
| style   | CDATA string | CSS to add                          | `<![CDATA[ .some-class { some-prop: some-value; } ]]>`                     |
| width   | integer      | Width of the template to be scaled  | 600                                                                        |
| height  | integer      | Height of the template to be scaled | 400                                                                        |

### 4.1. Twig

Twig will be rendered directly into the module HTML. It can be used to add custom CSS or HTML to the module.

It needs to be provides as a CDATA block, to prevent the XML parser from interpreting the HTML.

By setting a `width` and `height` attribute, the template will be scaled to match those dimensions in the player.

### 4.2. Handlebars (hbs)

When set in the template, the `hbs` node value will be used as a template for each item provided.

If it's defined in the module, it will be used as a template for the module itself.

We can use `{{ }}` with module or item properties, data can be rendered to the template.

## 5. Sample data

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

## 6. Assets

When assets are required for the module, they can be added to the `assets` node.

| Element | Type  | Description                       |
|---------|-------|-----------------------------------|
| asset   | Asset | A file to be added to the module. |

### Asset

| Attribute     | Type    | Description                                                                   | Options        | Sample value                |
|---------------|---------|-------------------------------------------------------------------------------|----------------|-----------------------------|
| `id`          | string  | ID of the asset.                                                              |                | `newImage`                  |
| `type`        | string  | Type of the asset.                                                            | `path`         | `path`                      |
| `mime`        | string  | Mime type of the asset.                                                       |                | `image/png`                 |
| `path`        | string  | Path to the asset.                                                            |                | `/modules/assets/image.png` |
| `cmsOnly`     | boolean | Is this asset only used in the CMS?                                           |                | true                        |
| `autoInclude` | boolean | Should this asset be automatically included in the player HTML? (css/js only) | Default: false | true                        |

And then the asset can be referenced in the module with the `[[assetId=newImage]]` syntax.

## 7. Data Type

Each `datatype.xml` file should have a top level node called `<dataTypes>`, inside which is each `<dataType>` node.

| Element  | Type     | Description                      | Options | Sample value |
|----------|----------|----------------------------------|---------|--------------|
| `id`     | string   | A unique ID for the datatype.    |         | `currency`   |
| `name`   | string   | A friendly name for the datatype |         | Currency     |
| `fields` | Fields[] | A array of fields                |         |              |

### 7.1. Field

| Element | Type   | Description             | Options | Sample value                           |
|---------|--------|-------------------------|---------|----------------------------------------|
| `title` | string | The title of this field |         | The time this quote was last refreshed |

### 7.1. Field Attributes

| Attribute | Type   | Description                                   | Sample value                  |
|-----------|--------|-----------------------------------------------|-------------------------------|
| `id`      | string | A unique ID for this field (used in widgets)  | time                          |
| `type`    | string | The data type this field should be treated as | number, text, datetime, image |