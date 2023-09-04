---
nav: "extend"
slug: "extend/custom-display-profiles"
alias: "custom-display-profiles"
title: "Create Custom Display Profiles"
---

# Introduction
**Available from CMS v3.1**

This document will help you create a custom display profile to extend the options available in core CMS.


What needs to be created:
- New Custom Middleware
- Edit form (twig file)

Then Middleware needs to be enabled in the settings-custom.php file.

## Middleware
You will want to create a new PHP class inside the /custom folder.

To make the process of creating a custom Display Profile easier, there is an interface that your class should implement
as well as a Trait that should help with everything you need.

The class therefore should begin with:

```php
class yourCustomProfileMiddlewareClass implements Middleware, CustomDisplayProfileInterface
{
    use CustomDisplayProfileMiddlewareTrait;
}
```

Since your new class implements the interfaces, you will get suggestions regarding all needed functions.

Thanks to CustomDisplayProfileMiddlewareTrait your new custom Display Profile Middleware class will have the
process function covered.

This function will check if Display Profile of specified type already exist, if not it will create it in the CMS.

After that you will be able to Add a new Display Profile with the same type, edit existing Profiles etc. in the CMS itself.

It will also register your custom Display Profile, using its name, type and default static function names - this can be overridden if needed.

This function will run automatically, after the Middleware is enabled in settings-custom.php file.

From `CustomDisplayProfileInterface` we need to create couple functions, your IDE should be able to get all required functions from the interface, and your class should look something like this now:

```php
class yourCustomProfileMiddlewareClass implements Middleware, CustomDisplayProfileInterface
{
    use CustomDisplayProfileMiddlewareTrait;
    
    /**
     * @inheritDoc
     */
    public static function getType(): string
    {
        // TODO: Implement getType() method.
    }

    /**
     * @inheritDoc
     */
    public static function getName(): string
    {
        // TODO: Implement getName() method.
    }

    /**
     * @inheritDoc
     */
    public static function getDefaultConfig(ConfigServiceInterface $configService): array
    {
        // TODO: Implement getDefaultConfig() method.
    }

    /**
     * @inheritDoc
     */
    public static function editCustomConfigFields(DisplayProfile $displayProfile,SanitizerInterface $sanitizedParams,?array $config,?Display $display,LogServiceInterface $logService): array 
    {
        // TODO: Implement editCustomConfigFields() method.
    }
}
```

Let us see what we need to return in these functions, by looking at the interface.

```php
    /**
     * Return Display Profile type
     * @return string
     */
    public static function getType():string;

    /**
     * Return Display Profile name
     * @return string
     */
    public static function getName():string;
```

For the first two function, we need to return strings, for the type and name of your custom Display Profile.


Next, we need a function that returns the default configuration for your Display Profile.

```php
    /**
     * This function should return an array with default Display Profile config.
     *
     * @param ConfigServiceInterface $configService
     * @return array
     */
    public static function getDefaultConfig(string ConfigServiceInterface $configService) : array;
```

Example for this function :
```php
        return [
            ['name' => 'collectInterval', 'default' => 60, 'type' => 'int']
        ]
```
All default options, and their default values need to be returned in this array.


The last function you need `editCustomConfigFields` handles any changes made on the Display Profile edit form and Display Edit form where the Display Profile settings can be overridden.

```php
    /**
     * This function handles any changes to the default Display Profile settings, as well as overrides per Display.
     * Each editable setting should have handling here.
     *
     * @param DisplayProfile $displayProfile
     * @param SanitizerInterface $sanitizedParams
     * @param array|null $config
     * @param Display|null $display
     * @param LogServiceInterface $logService
     * @return array
     */
    public static function editCustomConfigFields(DisplayProfile $displayProfile, SanitizerInterface $sanitizedParams, ?array $config, ?Display $display, LogServiceInterface $logService) : array;
```

As such it should have handling for each editable field on your custom Display Profile edit form.

Snippet code:
```php
        $changedSettings = [];
        $ownConfig = ($config === null);

        switch ($displayProfile->getClientType()) {
            case self::getType():
                if ($sanitizedParams->hasParam('emailAddress')) {
                    self::handleChangedSettings('emailAddress', ($ownConfig) ? $displayProfile->getSetting('emailAddress') : $display->getSetting('emailAddress'), $sanitizedParams->getString('emailAddress'), $changedSettings);
                    $displayProfile->setSetting('emailAddress', $sanitizedParams->getString('emailAddress'), $ownConfig, $config);
                }

                if ($sanitizedParams->hasParam('collectInterval')) {
                    self::handleChangedSettings('collectInterval', ($ownConfig) ? $displayProfile->getSetting('collectInterval') : $display->getSetting('collectInterval'), $sanitizedParams->getInt('collectInterval'), $changedSettings);
                    $displayProfile->setSetting('collectInterval', $sanitizedParams->getInt('collectInterval'), $ownConfig, $config);
                }

                if ($changedSettings != []) {
                    $logService->audit( ($ownConfig) ? 'DisplayProfile' : 'Display', ($ownConfig) ? $displayProfile->displayProfileId : $display->displayId, ($ownConfig) ? 'Updated' : 'Display Saved', $changedSettings);
                }

                return $config;
            default:
                return [];
        }
```

The `$changedSettings` array is used by a function `handleChangedSettings` from the Trait, then we use it to create audit log for each changed setting - this can be omitted if you do not wish to audit log changes in your custom Display Profile.

The `$sanitizedParams` SanitizerInterface contains all changed parameters on the submitted edit form, as such we use it to determine if setting was changed and if it was to update the Display Profile / Display Override config.
Use the built-in functions to get the type of the setting you need followed by the setting's name, as per the example above for `collectInterval`.


This should be all you need to implement in your Custom Middleware, if needed, there are more functions with default values that you can override from the trait.

## Edit Form
The twig edit form for your custom Display Profile should have all editable options in it.

The name of this file needs to match the return value of getCustomEditTemplate() function.

This function exists in the CustomDisplayProfileMiddlewareTrait trait and defaults to:```'displayprofile-form-edit-'. self::getType().'.twig'```
Which matches the naming convention of standard Display Profiles in the CMS.

If you've named your twig file differently, please override getCustomEditTemplate() function in your middleware and return the twig name there.

```twig
{% import "forms.twig" as forms %}

{% block formHtml %}
<here goes handling for the editable option in your Display Profile>
{% endblock %}
```

Copying one of the existing Display Profile edit forms might be a good starting point here.

Then editing it to suit the options needed in your custom Display Profile.

Example structure:
```twig
    <div class="row">
        <div class="col-md-12">
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item"><a class="nav-link active" href="#general" role="tab" data-toggle="tab">{% trans "General" %}</a></li>
                <li class="nav-item"><a class="nav-link" href="#advanced" role="tab" data-toggle="tab">{% trans "Advanced" %}</a></li>
                {% if commands|length > 0 %}
                    <li class="nav-item"><a class="nav-link" href="#commands" role="tab" data-toggle="tab">{% trans "Commands" %}</a></li>
                {% endif %}
            </ul>
            <form id="displayProfileForm" class="XiboForm form-horizontal" method="put" action="{{ url_for("displayProfile.edit", {id: displayProfile.displayProfileId}) }}">
                <div class="tab-content">
                    <div class="tab-pane active" id="general">
                        {{ include('displayprofile-form-edit-common-fields.twig') }}

                        {% set title = "Collect interval"|trans %}
                        {% set helpText = "How often should the Player check for new content."|trans %}
                        {% set options = [
                            { id: 60, value: "1 minute"|trans },
                            { id: 300, value: "5 minutes"|trans },
                            { id: 600, value: "10 minutes"|trans },
                            { id: 1800, value: "30 minutes"|trans },
                            { id: 3600, value: "1 hour"|trans },
                            { id: 5400, value: "1 hour 30 minutes"|trans },
                            { id: 7200, value: "2 hours"|trans },
                            { id: 9000, value: "2 hours 30 minutes"|trans },
                            { id: 10800, value: "3 hours"|trans },
                            { id: 12600, value: "3 hours 30 minutes"|trans },
                            { id: 14400, value: "4 hours"|trans },
                            { id: 18000, value: "5 hours"|trans },
                            { id: 21600, value: "6 hours"|trans },
                            { id: 25200, value: "7 hours"|trans },
                            { id: 28800, value: "8 hours"|trans },
                            { id: 32400, value: "9 hours"|trans },
                            { id: 36000, value: "10 hours"|trans },
                            { id: 39600, value: "11 hours"|trans },
                            { id: 43200, value: "12 hours"|trans },
                            { id: 86400, value: "24 hours"|trans }
                        ] %}
                        {{ forms.dropdown("collectInterval", "single", title, displayProfile.getSetting("collectInterval"), options, "id", "value", helpText) }}
                    </div>

                    <div class="tab-pane" id="advanced">
                        {% set title = "Embedded Web Server Port"|trans %}
                        {% set helpText = "The port number to use for the embedded web server on the Player. Only change this if there is a port conflict reported on the status screen."|trans %}
                        {{ forms.number("embeddedServerPort", title, displayProfile.getSetting("embeddedServerPort"), helpText) }}
                    </div>

                    {% if commands|length > 0 %}
                        <div class="tab-pane" id="commands">
                            {% include "displayprofile-form-edit-command-fields.twig" %}
                        </div>
                    {% endif %}
                </div>
            </form>
        </div>
    </div>
```

# Last step
Once the Middleware and Twig file are created, last thing you will need to do is to enable your custom middleware.

This is done in your `/custom/settings-custom.php` file, like follows:

```php
$yourCustomMiddlewareName = new \Xibo\Custom\<yourCustomMiddlewareClassName>();
$middleware = [$yourCustomMiddlewareName];
```
Once that's in place your Custom Middleware is active, and the new Custom Display Profile will be created automatically.