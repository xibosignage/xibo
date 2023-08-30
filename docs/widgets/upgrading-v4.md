---
nav: "widgets"
slug: "widgets/upgrading-v4"
title: "Upgrading to v4 - Widgets"
---

# Upgrading to v4

Xibo v4 has redesigned the widget system to make it simpler to use and more powerful. If you've written a custom Module for CMS version 3.x, you will need to make several code changes to make it work in CMS version 4.

If you have a module for an earlier version of Xibo we recommend skipping straight to v4.

## Overview

This documentation has detailed information for how to [create a module](creating_a_module.md) using the new developer tools. A key decision is whether your module needs to handle data and how you handle that data.

In your v3 module do you pull data from a third party system? If the answer is yes, then you should have a separate module and template in v4. If the answer is no, then you likely just need a module in v4.

### Properties

In v3 you manually created the HTML for your widget edit form, and parsed the responses out in `edit()`, validated them and saved them. In v4 this process is controlled by the XML definition of your module and your template.

To create properties for v4, we need to convert them from the v3 `moduleName-form-edit.twig` to the new `moduleName.xml` file in the [properties](creating_a_module.md#13-property) block. Note that, to be compatible with existing v3 modules, the property IDs must match those required by the `edit` function in `lib/Controller/moduleName.php`.

### Data

In v3 you did data retrieval and parsing in `getResource()`. If your module needs data in v4 you should implement a [data provider via one of the two methods](data-providers).

### Rendering

Rendering can be achieved by using a template for each item if a data provider is available, or by using a single template to generate the desired output. Alternatively, a combination of both can be used, with a main template and a template for each item. This is accomplished by using the [hbs templates](creating_a_module.md#142-hbs-templates) block for items or the [twig block](creating_a_module.md#141-twig) for the main template.

By also using the render flow [methods](creating_a_module.md#22-methods), it is possible to manipulate the data before rendering even further:

- `onInitialise` is called before the `hbs` templates are rendered, but after the page's structure is defined with the `twig` template. It can be used to initialise variables or methods that are used in the render calls, or to prepare the HTML structure before data is processed.

- `onParseData` will only be called if we have a provider with data items, and can be mostly used to manipulate the data before it is rendered.

- `onRender` and `onTemplateRender` are called in sequence after the main template is rendered. They can be used to manipulate the HTML structure after the data is processed. Both methods are invoked each time the widget changes dimension in the Layout Designer. It is important to ensure that the methods clear any changes made in the previous call to avoid unexpected results.

- `onVisible` is called when the widget is visible in the player or Layout Designer preview. It can be used to initiate animations or other actions that should only be performed when the widget is visible.

We can pass data (variables and methods) between these methods by using the [Xibo Interactive Control](creating_a_module.md#4-using-the-xibo-interactive-control), if needed.


# Upgrading to earlier versions?
Not on v4 yet? We have instructions for upgrading to earlier versions:

 - [Upgrading to v3](upgrading-v3)
 - [Upgrading to v2](upgrading-v2)