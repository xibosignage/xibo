---
nav: "cms-api"
slug: "cms-api/auth"
alias: "cms-api-overview"
title: "Authentication - Integrate with Xibo"
---


# Authentication
Securing the CMS is of utmost importance and the API is secured behind an oAuth resource server which requires 
a valid `access_token` to be provided before access will be granted.

An `access_token` can be obtained from the CMS Authorization Server.

Once an `access_token` has been obtained it should be provided with every request using an Authorization header. The 
`access_token`'s are *Bearer Tokens* and should therefore be provided as such:

```
Authorization: Bearer <<access token>>
```



### Client Information

Applications connecting to the CMS API must do so using a `clientId` and `clientSecret` which are available from the Applications page.

An application needs to be added to the CMS before an authorisation request can be processed. After adding an Application it can be granted access to two different types of credentials, called grant types.



### Grant Types

The CMS supports two grant types:
 - access_code
 - client_credentials

The grant type requested must be supplied in the `grant_type` query parameter whenever requesting a token.

Applications added to the CMS should specify which grant types are allowed to use those client credentials. The `client_credentials` grant is typically used for machine-to-machine communication, whereas the `access_code` grant type is used to authorise a user.



### Authorization Server

The CMS authorization server is used to obtain an `access_token` and can be found at `/api/authorize`. The 
authorization server supports two methods:

 - `/api/authorize/` initiate the `access_code` grant
 - `/api/authorize/access_token` obtain a token




