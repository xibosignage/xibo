---
nav: "widgets"
slug: "widgets/hello-world"
alias: "modules-and-widgets"
title: "Hello World - Widgets"
---

# Hello world
This is a super simple example of Xibo's module system in action. If you copy this code into your Xibo v4 CMS installation, you will be able to add a simple message to your Layouts.

{tip}The example is trivial on purpose! :){/tip}


## Module XML

```xml
<module>
    <id>xibosignage-helloworld</id>
    <name>Embedded</name>
    <author>Xibo Signage</author>
    <description>Hello World!</description>
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
            <script type="text/javascript">
                $(function() {
					window.scaleContent = true;
					$("body").xiboLayoutScaler(globalOptions);
                });
            </script>
        ]]></twig>
    </stencil>
</module>
```


## Enable the Module


## Add to a Layout
