---
nav: "extend"
slug: "extend/index"
title: "Extend Xibo"
alias: "extending-the-xibo-platform"
excerpt: "This section primarily focuses on leveraging the tools provided to create custom extensions to the platform"
---

# Extending Xibo

This section primarily focuses on leveraging the tools provided to create custom extensions to the platform, however understanding how this works will also help a developer wanting to extend the core CMS and contribute that change back to the project. Extensions sit within or connect directly with the Xibo code base and therefore **must be released** under the AGPLv3 open source licence.

Xibo has a rich tool set for extension and custom modifications which, where possible, use well tested industry standards. The tool set Xibo provides consists of:

 - Tasks
 - Middleware
 - Events
 - Connectors

Each tool serves a different purpose and one or more tools may need to be used to fulfil all requirements. They are discussed in the following sections.

### Auto Loading
Auto loading is discussed in more detail in the architecture section of these docs as it is a core tenet of the way custom development happens. In brief, Xibo uses PHP's Composer tool to manage dependencies and to auto-load its own classes.

In order to provide a simple way to extend the software, all PHP classes in the `/custom` folder which exist in the `Xibo\Custom\` namespace are auto-loaded into the application stack with each request. Whether you are creating a new Module, Task or hooking to some Events with Middleware, your code should exist in the `custom` folder and namespace.

Themes exist in the `/web/theme/custom/<theme_name>` folder and are the exception to auto-loading as Themes cannot implement any PHP directly (they use Twig templates, HTML and CSS).

---------

We advise reading through each of the following sections before embarking on any design or implementation work so that you can be sure to select the right tool for the job. If you'd like to run anything past us, please do open a new topic in the dev category of our community forum.