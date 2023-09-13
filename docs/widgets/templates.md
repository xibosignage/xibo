---
nav: "widgets"
slug: "widgets/templates"
title: "Templates - Widgets"
---

# Templates

A template is the object used to represent an element, stencil (element group) or static template; used for Data Widgets. All data widgets must have templates so that Xibo knows how to visualise the data returned by the Module.

| Type            | Description                                                                                                            |
|-----------------|------------------------------------------------------------------------------------------------------------------------|
| `element`       | Rendering for a single property on a data item                                                                         |
| `element-group` | A preconfigured group of elements which together form a Stencil shown in the Layout Editor toolbox for the data widget |
| `static`        | A static template, optionally with properties to customise appearance and behaviours.                                  |

They are defined using XML files, in the same way as modules. The [xml definition](xml-definitions#content-2-template) describes the options available.

| Type                | Location                                                 |
|---------------------|----------------------------------------------------------|
| Core template XML   | `/modules/templates`                                     |
| Custom template XML | `/custom/modules/templates`                              |

## RSS - a worked example
Xibo's RSS module is a good example of a data widget. There is a `rss-ticker.xml` file which contains the properties found on the configure tab and a widget provider to fetch data from the configured URL. It declares it's `dataType` as "article", which has the following properties:

```php
    public function getDefinition(): DataType
    {
        $dataType = new DataType();
        $dataType->id = self::$NAME;
        $dataType->name = __('Article');
        $dataType
            ->addField('title', __('Title'), 'text')
            ->addField('summary', __('Summary'), 'text')
            ->addField('content', __('Content'), 'text')
            ->addField('author', __('Author'), 'text')
            ->addField('permalink', __('Permalink'), 'text')
            ->addField('link', __('Link'), 'text')
            ->addField('date', __('Created Date'), 'datetime')
            ->addField('publishedDate', __('Published Date'), 'datetime')
            ->addField('image', __('Image'), 'text');
        return $dataType;
    }
```

Xibo provides elements for each of these data fields in the `article-elements.xml` file, and some static templates in the `article-static.xml` file.

We can easily create a new static template which renders out article data types:

```xml
<template>
    <id>article_custom_1</id>
    <type>static</type>
    <dataType>article</dataType>
    <title>My Custom Template</title>
    <startWidth>600</startWidth>
    <startHeight>200</startHeight>
    <properties>
        <property id="effect" type="effectSelector" variant="all">
            <title>Effect</title>
            <helpText>Please select the effect that will be used to transition between items.</helpText>
            <default>noTransition</default>
        </property>
        <property id="speed" type="number">
            <title>Speed</title>
            <helpText>The transition speed of the selected effect in milliseconds (normal = 1000) or the Marquee Speed in a low to high scale (normal = 1)</helpText>
            <default>1000</default>
        </property>
    </properties>
    <stencil>
        <hbs><![CDATA[
<div class="article">
    <div>
        <div class="title">
            <strong>{{title}}</strong>
        </div>
    </div>
</div>
        ]]></hbs>
        <style><![CDATA[
.title {
    font-size: 3rem;
}
        ]]></style>
    </stencil>
    <onTemplateRender><![CDATA[
// id: The id of the widget
// target: The target element to render
// items: The items to render
// properties: The properties for the widget
// -------------------------------------------
$(target).xiboLayoutScaler(properties);
$(target).xiboTextRender(properties, $(target).find('#content .article'));
    ]]></onTemplateRender>
</template>
```

Included here is a very basic template which will render out the title field of each data item. `xiboTextRender` will split that into pages if an effect has been selected (via the effects selector output as a property).