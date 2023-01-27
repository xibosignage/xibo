---
nav: "widgets"
slug: "widgets/upgrading-v4"
alias: "upgrading-your-custom-module-to-cms-version-4"
title: "Upgrading to v4 - Widgets"
---

# Upgrading to v4

If you've written a custom Module for CMS version 3.x, you will need to make several code changes to make it work and look correct in CMS version 4.

Please note, we've addressed the changes from 2.x to version 3.x in an [earlier page](https://xibosignage.com/docs/developer/widgets/upgrading-v3), please make sure you have done these changes first.

The new CMS version 4 has a complete restructuring of modules, and the changes are quite extensive. This page will guide you through the changes you need to make to your module to make it work in CMS version 4.

## How to start

Start by looking at the [following page](creating_a_module.md) to see the documentation for the new module structure.

## Data and provider

...

## Properties

To create modules for v4, we need to convert them from the v3 `moduleName-form-edit.twig` to the new `moduleName.xml` file in the [properties](creating_a_module.md#13-property) block. Note that, to be compatible with existing v3 modules, the property IDs must match those required by the `edit` function in `lib/Controller/moduleName.php`.

## Rendering

Rendering can be achieved by using a template for each item if a data provider is available, or by using a single template to generate the desired output. Alternatively, a combination of both can be used, with a main template and a template for each item. This is accomplished by using the [hbs templates](creating_a_module.md#142-hbs-templates) block for items or the [twig block](creating_a_module.md#141-twig) for the main template.

By also using the render flow [methods](creating_a_module.md#22-methods), it is possible to manipulate the data before rendering even further:

- `onInitialise` is called before the `hbs` templates are rendered, but after the page's structure is defined with the `twig` template. It can be used to initialise variables or methods that are used in the render calls, or to prepare the HTML structure before data is processed.

- `onParseData` will only be called if we have a provider with data items, and can be mostly used to manipulate the data before it is rendered.

- `onRender` and `onTemplateRender` are called in sequence after the main template is rendered. They can be used to manipulate the HTML structure after the data is processed. Both methods are invoked each time the widget changes dimension in the Layout Designer. It is important to ensure that the methods clear any changes made in the previous call to avoid unexpected results.

- `onVisible` is called when the widget is visible in the player or Layout Designer preview. It can be used to initiate animations or other actions that should only be performed when the widget is visible.

We can pass data (variables and methods ) between these methods by using the [Xibo Interactive Control](creating_a_module.md#4-using-the-xibo-interactive-control), if needed.
