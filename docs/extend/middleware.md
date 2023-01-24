---
nav: "extend"
slug: "extend/middleware"
alias: "custom-middleware"
title: "Middleware - Extend Xibo"
---

# Middleware

Middleware surrounds the Slim application like an onion and is executed before and after the main request in LIFO order. Additional Middleware can be provided by adding to the  `$middleware`  array in  `/web/settings.php` .

The Middleware added by the core application depends on the entry point that has been used. For example, the web/api entry points use a different authentication Middleware (one cms-auth and the other oauth2).

Custom Middleware is added to all entry points.