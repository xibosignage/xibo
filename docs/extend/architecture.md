---
nav: "extend"
slug: "extend/architecture"
alias: "application-architecture"
title: "Architecture - Extend Xibo"
excerpt: "Xibo is a client server application at it’s heart. It has a central content management system and one or more Player applications connecting to it."
---

# Application Architecture

Xibo is a client server application at it's heart. It has a central content management system and one or more Player applications connecting to it. By design much of the functionality provided is provided by the CMS and transferred to the Player using the standard Player API.

If a requirement you're working on involves changing the Player API or Player software we encourage you to raise your requirement with us, so that we can assess whether it is something that the whole solution can benefit from.

The rest of this page discusses the CMS architecture.

> NOTE: This documentation needs updating for Xibo v3/v4.

-----------------

The CMS web application written in PHP using the Slim4 framework. 

If Slim4 is entirely new to you then it is advisable to break out of this documentation and review the [Slim4 documentation](http://docs.slimframework.com/) to understand how that works. Slim4 was chosen because it provides a minimal framework to handle Middleware, Routing, Dependency Injection, etc, without the overhead of other frameworks.

The intention of the architecture is to provide a single Controller to service both the WEB and API channels. Therefore the CMS has two main entry points:

 - `/web/index.php`
 - `/web/api/index.php`

Requests to each point are routed to the same end controller - for example:

 - `GET http://xibo/display`
 - `GET http://xibo/api/display`

Both end up at `Display::grid()` - the CMS framework knows how to format each response accordingly, because of the Middleware that has been wrapped around each entry point.

Routes accessed via the API entry point will not have Twig templates available for formatting the response and in these cases the response will be JSON formatted. The entry point can be tested by calling `$app->getName()`.



### Middleware

Middleware surrounds the Slim application like an onion and is executed before and after the main request in LIFO order. Additional Middleware can be provided by adding to the `$middleware` array in `/custom/settings-custom.php`.

The Middleware added by the core application depends on the entry point that has been used. For example, the web/api entry points use a different authentication Middleware (one cms-auth and the other oauth2).

Custom Middleware is added to all entry points.



### Routing

Routes are added using short hand notation, for example:

```php
$app->get('/display', '\Xibo\Controller\Display:grid')->name('display.search');
```

When routes are matched the Controller is looked up in the DI container. Therefore controllers should always be added to the DI container.



### Dependency Injection

The CMS strictly injects all dependencies into the constructor of each object it needs. Controller and Factories (these are actually Repositories) are setup in Slim's DI container by the `State` Middleware.

To provide additional controllers, these should be registered to the `Slim::container` in Middleware.



### Database access

The database is MySQL and is accessible through a `PdoStorageService` configured in the `Storage` Middleware.



### Application State

The framework provides an `ApplicationState` object which can be used to conditionally format a response. It is not necessary to use this object if you would rather format your own response.



### Twig templates

When using the `/web/index.php` entry point it is advisable but not necessary to render output to the browser using the Twig template library. This is included in the CMS code and has helper methods in the `ApplicationState` object. This should be done for any page which should output HTML.

Themes should be used to provide additional templates for rendering.

A Controller should use the `ApplicationState` object and set the following properties:

 - `ApplicationState::template` - set to the name of the template without it's extension.
 - `ApplicationState::setData()` - an array of data to provide to the template



### Logging

While developing it is advisable to put the CMS installation into Test mode so that full logging output is available in the event of any errors.



## Examples

### Wiring up a new theme link

You've developed a custom theme which exposes a new link on the navigation menu (or anywhere else). 

**We recommend you use a theme for custom modifications so that they are not overwritten during an upgrade**. 

This link should take some action provided by a Custom Route/Controller.

Your link looks like:

```twig
{% if currentUser.routeViewable("/myapp") %}
<li class="sidebar-list"><a href="{{ urlFor("test.view") }}">{% trans "Test" %}</a></li>
{% endif %}
```

The `urlFor` method will look to connect to a named route - `test.view` - and
this route will need to be provided.

Middleware is used to wire up the new route - create a Middleware file in the
`/custom` folder.

```php
<?php
namespace Xibo\Custom;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Xibo\Middleware\CustomMiddlewareTrait;

/**
 * Class MyMiddleware
 * @package Xibo\custom
 *
 * Included in `custom/settings-custom.php`
 * $middleware = [new \Xibo\Custom\MyMiddleware()];
 */
class MyMiddleware implements MiddlewareInterface
{
    use CustomMiddlewareTrait;

    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        // Register a new controller with DI
        // This Controller uses the CMS standard set of dependencies. Your controller can
        // use any dependencies it requires.
        // If you want to inject Factory objects, be wary of circular references.
        $this->getContainer()->set('\Xibo\Custom\MyController', function ($c) {
            $controller = new MyController();
            $controller->useBaseDependenciesService($this->getFromContainer('ControllerBaseDependenciesService'));
            return $controller;
        });

        // Next middleware
        return $handler->handle($request);
    }

    /**
     * Add routes
     * @return $this
     */
    public function addRoutes()
    {
        // Register some new routes
        $this->getApp()->get('/myapp/test', ['\Xibo\Custom\MyController', 'testView'])->setName('test.view');
        return $this;
    }
}
```

The URL chosen will be automatically checked for permissions by the CMS Middleware. If you want the route to be accessible by users other than super admins, you should add `myapp` as a page record in the `pages` database table.

The Controller should be provided also:

```php
<?php
namespace Xibo\Custom;

use Slim\Http\Response as Response;
use Slim\Http\ServerRequest as Request;
use Xibo\Controller\Base;

/**
 * Class MyController
 * @package Xibo\Custom
 */
class MyController extends Base
{
    /**
     * Display Page for Test View
     */
    public function testView(Request $request, Response $response): Response
    {
        // Call to render the template
        //$this->getState()->template = 'twig-template-name-without-extension';
        //$this->getState()->setData([]); /* Data array to provide to the template */

        // Output directly
        $this->setNoOutput(true);
        echo 'String Output';
        
        // Always return through render.
        return $this->render($request, $response);
    }
}

```

The Middleware needs to be wired up in the `settings.php` file:

```php
$middleware = [new \Xibo\Custom\MyMiddleware()];
```

With this code added, visiting the CMS causes the new Middleware to be called, which registers your new Controller and Route. If the link visited matches your route, the Controller Method is executed and its output rendered.

This Controller example uses the `ApplicationState` to render a Twig template. The template would need to be available in the view path of the active theme. If you are using a custom theme this is `/web/theme/custom/themeName/views` (unless you have specified an alternative path in your theme config).

Create a file in your theme named `twig-template-name-without-extension.twig` for the simplest example of a Twig template.

```twig
{% extends "authed.twig" %}
{% import "inline.twig" as inline %}

{% block pageContent %}
    <div class="widget">
        <div class="widget-title">{% trans "Page Name" %}</div>
        <div class="widget-body">
            
        </div>
    </div>
{% endblock %}
```

Alternatively you can directly modify the browser output within the controller. To do this you need to inform the `ApplicationState` object that it should not output anything. For example:

```php
$this->setNoOutput(true);
echo 'This is my output to the browser';
```
