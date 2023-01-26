---
nav: "cms-api"
slug: "cms-api/making-requests"
title: "Making Requests - Integrate with Xibo"
---

# Making Requests

This section deals with general information related to making requests.



## Enveloping

All requests can be enveloped by adding `envelope=1` as a query parameter.



## Errors

API errors are reported via the 4xx and 5xx HTTP response codes, the most common of which are:

 - 404 Not Found (the resource could not be found)
 - 409 Conflict (the request conflicts with an existing entity)
 - 422 Unprocessable Entity (the entity provided is invalid)

Extra information is available in the response body and is JSON formatted. A human readable error message is presented, the HTTP status code and a data block indicating further information.

An example 422 response is below:

```json
{
    "error": {
        "message": "Layout Name must be between 1 and 50 characters",
        "code": 422,
        "data": {
            "property": "name"
        }
    }
}
```

5xx errors indicate an issue with the CMS environment and extra information will be available in the CMS logs.



## Grid Data - lists of records

Lists of records, henceforth referred to as grids, are paged by default, with a default page size of 10 records. They also have a default sort order applied to them, which is appropriate for that record type.



### Paging

Paging is controlled by 2 parameters, `start` and `length`. The `start` parameter denotes at which record in the set the results should start from, and `length` denotes the number of records to return. The default `length` is 10 records which means to get page 2, `start=20` would be provided.

The headers of the response contain extra information related to paging, these are:

 - `X-Total-Count`: The total count of records (all pages)
 - `Link`: Links pointing to the first, prev, next and last pages (as appropriate)

The link header is [RFC formatted](http://tools.ietf.org/html/rfc5988) and consists of a url and `;` and a `rel=` 
(relationship) attribute.

For example, the headers returned with page 1 are:

```
Link: <http://localhost/api/layout?start=20&length=10>; rel="next", <http://localhost/api/layout?start=0&length=10>; rel="first"
X-Total-Count: 26
```



### Sorting

Sorting happens in two steps using a columns array and an order array. The columns array describes the fields that 
should be ordered, and the order array describes how they should be ordered and in what order.

Taking the layout grid as an example, lets imagine we want to order by the `duration` of the layout, descending. We do 
this by specifying a columns array:

```
columns[1][data]:duration
```

And an order array:

```
order[1][column]:1
order[1][dir]:desc
```

