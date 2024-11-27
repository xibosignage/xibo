---
nav: "cms-api"
slug: "cms-api/index"
title: "Integrating with Xibo"
alias: "integrating-with-xibo"
excerpt: "Integrating applications opens the door to many exciting possibilities, and we’ve designed the Xibo CMS from first principles with maximum support for integration."
---

# Integrating with Xibo

Integrating applications opens the door to many exciting possibilities, and we've designed the Xibo CMS from first principles with maximum support for integration. The heart of the CMS is an API which is used by Xibo's own user interface, and can also be accessed via a 3rd party! The CMS API is used to pull data from the Xibo CMS into another system, or push data from another system into the CMS. 

Our API makes exciting opportunities to integrate Xibo with other systems possible! For example, imagine an integration with a point of sale system which pushed complimentary products to the signage when a customer purchased something.

The CMS API is a RESTful API protected by oAuth. It can be consumed at `//yoururl/api` and exposes routes for all CMS operations. The API is [OpenAPI Compliant](http://swagger.io/) and the documentation is presented using Swagger-UI. Every Xibo CMS install has a `/swagger.json` end point which can be used to provide an API document specific to the version of Xibo running.

>  The API document in this manual is always for the latest release.

[View the API documentation](https://xibo.org.uk/manual/api/).

## Older versions
The explore bar at the top of the Swagger documentation can be used to load the API docs from older releases.

 - 3.3: https://raw.githubusercontent.com/xibosignage/xibo-cms/release33/web/swagger.json
 - 2.3: https://raw.githubusercontent.com/xibosignage/xibo-cms/release/23/web/swagger.json 
 - 1.8: https://raw.githubusercontent.com/xibosignage/xibo-cms/release/18/web/swagger.json

## Postman
You can copy/paste the `swagger.json` from the above links into Postman's import function.

### Can't find an API route you need?

Xibo has a comprehensive system for customisation and the API is no exception. You can use custom Middleware, Routes and Controllers to implement your own API endpoints to do whatever you need to! The most common use is to group up existing Xibo operations into something easier to call by the 3rd party!

These are documented in our [section on extending Xibo](extend).

