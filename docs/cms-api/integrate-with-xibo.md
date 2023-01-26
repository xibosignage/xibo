---
nav: "cms-api"
slug: "cms-api/index"
title: "Integrating with Xibo"
alias: "integrating-with-xibo"
---

# Integrating with Xibo

Integrating applications opens the door to many exciting possibilities and we've designed the Xibo CMS from first principles with maximum support for integration. The heart of the CMS is an API which is used by Xibo's own user interface, and can also be accessed via a 3rd party! The CMS API is used to pull data from the Xibo CMS into another system, or push data from another system into the CMS. 

We call any integration a "Connector" because it connects two systems together. Our API makes exciting opportunities to integrate Xibo with other systems possible! For example, imagine an integration with a point of sale system which pushed complimentary products to the signage when a customer purchased something.

The CMS API is a RESTful API protected by oAuth. It can be consumed at `//yoururl/api` and exposes routes for all CMS operations. The API is [OpenAPI Compliant](http://swagger.io/) and the documentation is presented using Swagger-UI. Every Xibo CMS install has a `/swagger.json` end point which can be used to provide an API document specific to the version of Xibo running.



>  The API document in this manual is always for the latest release.



[View the API documentation](https://xibo.org.uk/manual/api/).



### Can't find an API route you need?

Xibo has a comprehensive system for customisation and the API is no exception. You can use custom Middleware, Routes and Controllers to implement your own API endpoints to do whatever you need to! The most common use is to group up existing Xibo operations into something easier to call by the 3rd party!

These are documented in our [section on extending Xibo](extend).

