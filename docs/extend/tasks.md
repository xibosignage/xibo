---
nav: "extend"
slug: "extend/tasks"
alias: "recurring-tasks"
title: "Tasks - Extend Xibo"
---

# Tasks

The CMS will look in the `/custom` folder for any file ending in `.task`, these files will be loaded
into the Task Add form for deployment on the CMS.

The `.task` file should contain the Tasks configuration information, including an auto-loaded class
definition for the task. An example is shown below:

``` json
{
  "name": "My Custom Task",
  "class": "\\Xibo\\Custom\\CustomTask",
  "options": {
    "option1": "value1"
  }
}
```

This task would expect to be able to instantiate `\Xibo\Custom\CustomTask` at runtime.