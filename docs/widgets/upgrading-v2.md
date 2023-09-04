---
nav: "widgets"
slug: "widgets/upgrading-v2"
alias: "upgrading-your-custom-module-to-cms-version-2"
title: "Upgrading to v2 - Widgets"
---

# Upgrading to v2

If you've written your custom Module for CMS version 1.8 or earlier, you will need to make several code changes to make it work and look correct in CMS version 2.

The most significant changes are covered below:

## No Add form
In version 2 of the CMS and later, there are no longer Widget add forms or functions exposed directly in the Widget code.

Since your custom module will have those, you will need to remove the following:
`Add()` function from your customModule.php code
customModule-form-add.twig will also be no longer needed.

If your customModule requires a specific parameter to be set on Add, you can make the edit form in two steps with : 
`customModule-form-edit`
`customModule-form-edit-step1` 

Keep in mind that it should be PUT Widget edit request on both forms, the step parameter on the form and in php code should handle which one of those two Twig files is presented to the User.

A good example of an implementation of the above is datasetticker and datasetview modules, which need the dataSetId to be set in the step1, you can check for the reference on how that needs to be implemented.

## New Layout Designer
Version 2 of the CMS comes with a new and improved Layout designer which also slightly alters the way Widget edit forms now work.

Changes you will most likely need to make are detailed below:

### Add customModule-designer-javascript.twig file

Include the customModule-designer-javascript.twig in lib/Widget/customModule.php main class with the following function:
```php
public function layoutDesignerJavaScript() {
    return 'customModule-designer-javascript';
}
```

In this new file you will use javascript `<script>` tags to handle fields that depend on values from other fields - useDuration, overrideTemplate and similar.

You can use the following functions, that will be accessible for your custom Module, without setting a callback on your edit form:
```js
<script type="text/javascript">
    // Runs after edit form opens
    function customModule_form_edit_open() {
       
    }

    // Runs before form submit
    function customModule_form_edit_submit() {

    }
</script>
```

There are various `formHelpers` that you can use to setup all required input fields and text areas.
It might be helpful to look at core modules designer-javascript files, for example the Ticker widget.

You can also add a `<style>` tag and set a custom icon for your custom Module:
```css
<style>
    .module-icon-customModule:before {
        content: "\f0e6" !important;
    }
</style>
```

### Advanced Text Editor & Templates

If your custom Module requires templates you will also need to make changes to the Edit form and Module code.

You will need to add two new options to your custom Module `ta_text_advanced` and `noDataMessage_advanced` parameters and make changes to the Twig Edit Form to allow switching Visual Editor on/off etc.

Both of those text areas should be setup using the formHelpers in customModule-designer-javascript.twig file.

In most cases you will also want to make your custom Module look consistent with core Modules, as such the structure of the form-edit twig file will need to be adjusted as well.

We'd recommend to look at form-edit files of the existing core Modules to see how is that implemented in version 2.