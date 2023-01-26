---
nav: "widgets"
slug: "widgets/creating-a-module"
alias: "modules-and-widgets"
title: "Creating a Module - Widgets"
---

# Creating a Module

"Module" is Xibo's name for the logic which sits behind a Widget. Users create widgets, developers create modules.

{tip}Xibo `v4` has extensive changes to the way widgets are modelled and developed. If you are thinking of making a widget, we **recommend** using `v4` as your starting point.{/tip}


## What do you want to create?


| I want to...                                                     | ...you need a                                                                                                                                                         |
| ---------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Upload a media file to assign directly to a Display.             | Module XML file with `regionSpecific=0` and `assignable=0`.                                                                                                           |
| Upload a media file and tell Xibo how to show it.                | Module XML file with `regionSpecific=0` and `assignable=1`.                                                                                                           |
| Create some reusable/configurable HTML for Layouts.              | Module XML file with `regionSpecific=1` and `assignable=1`.                                                                                                           |
| Create a new way to visualise an existing Widget which has data. | Template XML file with a matching `dataType`.                                                                                                                         |
| Pull, parse and display data on a Layout.                        | Module XML file with `regionSpecific=1`, `assignable=1`, a `dataType` and maybe a `class` or Connector. You also need a Template XML file with a matching `dataType`. |


## Hello World...
It is useful to start with a simple example. Here it is, the obligatory [hello world example](hello-world).


## File locations
Xibo's module system uses XML and where necessary for data retrieval, PHP files.

These files are located in the following places:

| Type                | Location                                                 |
| ------------------- | -------------------------------------------------------- |
| Core module XML     | `/modules`                                               |
| Core template XML   | `/modules/templates`                                        |
| Custom module XML   | `/custom/modules`                                     |
| Custom template XML | `/custom/modules/templates`                              |
| Custom PHP          | `/custom` (Autoloaded from the `\Xibo\Custom` namespace) |


## XML definitions

### Module

| Element         | Type         | Description                                                                                                                                                                                                                                       | Sample value    |
| --------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| id              | string       | A unique ID for the module. Core modules are prefixed with `core-`. If you want to distribute your module it would be sensible to give it a prefix personal to you.                                                                               | `core-embedded` |
| name            | string       | This is the friendly name of your module. It will be shown in the Layout Designer.                                                                                                                                                                |                 |
| author          | string       | You :), only shown on the Module admin page.                                                                                                                                                                                                      |                 |
| description     | string       | A description for the module, only used on the Module admin page.                                                                                                                                                                                 |                 |
| class           | string       | The class name of a Widget Provider, if needed. Not all modules need this, see below.                                                                                                                                                             |                 |
| type            | string       | This is the internal identifier for your module and is what gets recorded on the Layout XLF file and sent to the Player. This does not have to be unique, the CMS will choose the first available module of a particular type to render a Widget. |                 |
| dataType        | string       | If this module returns data, this is the data type of that data.                                                                                                                                                                                  | `article`       |
| schemaVersion   | integer      | Schema Version - can use used to determine different rendering from past versions.                                                                                                                                                                | 1               |
| assignable      | integer      | Should this module be assignable - used for Library modules.                                                                                                                                                                                      | 1               |
| regionSpecific  | integer      | Is this Module for the Library (0) or a Widget on a Layout (1)                                                                                                                                                                                    | 1               |
| renderAs        | string       | Render natively or as HTML. If you are making a Player that will understand how to render the module set to `native`. Native modules must provide a preview stencil.                                                                              | `html`          |
| defaultDuration | integer      | When the user has declined to provide a duration for the Widget, what should the duration be.                                                                                                                                                     | 60              |
| settings        | Properties   | Settings shown on the Module admin page.                                                                                                                                                                                                          |                 |
| properties      | Properties   | Properties shown in the configuration panel of the Layout and Playlist editors.                                                                                                                                                                   |                 |
| preview         | Stencil      | A stencil for previewing                                                                                                                                                                                                                          |                 |
| stencil         | Stencil      | A stencil for the HTML to be sent to the Player                                                                                                                                                                                                   |                 |
| dataParser      | CDATA string | If needed, the inside of a JavaScript function for pre-parsing data items.                                                                                                                                                                        |                 |
| sampleData      | CDATA string | A JSON data item to use as a sample                                                                                                                                                                                                               |                 |

The data parser has the following local variables:

| Name    | Description                |
| ------- | -------------------------- |
| item    | The data item to be parsed |
| options | The options for the widget |


### Template

| Element    | Description | Sample value        |
| ---------- | ----------- | ------------------- |
| id         |             |                     |
| type       |             |                     |
| dataType   |             |                     |
| properties |             |                     |
| stencil    |             | see Stencil         |
| renderer   |             | `<![CDATA[ ... ]]>` |

The renderer has the following local variables:

| Name    | Description                  |
| ------- | ---------------------------- |
| id      | The id of the widget         |
| target  | The target element to render |
| options | The options for the widget   |


### Property

| Attribute | Description | Sample value |
| --------- | ----------- | ------------ |
| id        |             |              |
| type      |             |              |
| mode      |             |              |

| Element             | Description | Sample value |
| ------------------- | ----------- | ------------ |
| title               |             |              |
| helpText            |             |              |
| default             |             |              |
| options             | option      |              |
| visibility          |             |              |
| playerCompatibility |             |              |

#### Option

#### Visibility

| Element | Description | Sample value |
| ------- | ----------- | ------------ |
| test    |             |              |

#### Visibility Test

| Element   | Description | Sample value |
| --------- | ----------- | ------------ |
| condition |             |              |

#### Visibility Test Condition

| Element    | Description    | Sample value    |
| --- | --- | --- |
| nodeValue    |     |     |

| Attribute | Description | Sample value |
| --------- | ----------- | ------------ |
| field     |             |              |
| type      |             |              |

Condition test types:

| Name | Description |
| ---- | ----------- |
| eq   |             |
| gt   |             |

#### Supported Property Types

| Name     | Description |
| -------- | ----------- |
| input    |             |
| dropdown |             |
| checkbox |             |

#### Player Compatibility

| Attribute | Description | Sample value |
| --------- | ----------- | ------------ |
| windows   |             |              |
| linux     |             |              |
| android   |             |              |
| webos     |             |              |
| tizen     |             |              |

| Element   | Description | Sample value |
| --------- | ----------- | ------------ |
| nodeValue |             |              |


### Stencil

| Element | Description | Sample value        |
| ------- | ----------- | ------------------- |
| twig    |             | `<![CDATA[<p>Some HTML</p>]]>`                    |
| hbs     |             | `<![CDATA[ ... ]]>` |
| width   |             | 960                 |
| height  |             | 350                 |

