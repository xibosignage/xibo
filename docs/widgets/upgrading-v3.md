---
nav: "widgets"
slug: "widgets/upgrading-v3"
alias: "upgrading-your-custom-module-to-cms-version-3"
title: "Upgrading to v3 - Widgets"
---

# Upgrading to v3

If you've written a custom Module for CMS version 2.x, you will need to make several code changes to make it work and look correct in CMS version 3.

Please note, we've addressed the changes from 1.8 to version 2.x in an [earlier page](https://xibo.org.uk/docs/developer/upgrading-your-custom-module-to-cms-version-2), please make sure you have done these changes first.

## Request/Response objects
In version 3 of the CMS we use PSR request and response objects liberally throughout the application code base. This effects the Module Edit and Settings methods, which now have the following signature:

```php
/**
 * Edit Widget
 * @param \Slim\Http\ServerRequest $request
 * @param \Slim\Http\Response $response
 * @return \Slim\Http\Response
 * @throws GeneralException
 */
public function edit(Request $request, Response $response): Response;

/**
 * Module Settings
 * @param \Slim\Http\ServerRequest $request
 * @param \Slim\Http\Response $response
 * @throws GeneralException
 * @return \Slim\Http\Response
 */
public function settings(Request $request, Response $response): Response;
```

In most cases you will return the `$response` provided without modification, however you are free to adjust it if necessary, for example to add some headers, or change the return code.


## Sanitizer
Version 3 has a new Sanitizer library, which is loaded and accessed in a different way. Firstly we get the request parameters using `$request->getParams()`, and then we pass those into our Sanitizer and receive back a new Sanitizer object which we can pull out Sanitized parameters from.

```php
$sanitizedParams = $this->getSanitizer($request->getParams());
$name = $sanitizedParams->getString('name');
```