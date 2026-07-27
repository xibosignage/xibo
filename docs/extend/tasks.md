---
nav: "extend"
slug: "extend/tasks"
alias: "recurring-tasks"
title: "Tasks - Extend Xibo"
excerpt: "The CMS will look in the /custom folder for any file ending in .task, these files will be loaded into the Task Add form for deployment on the CMS."
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

```php
<?php

namespace Xibo\Custom;

use Xibo\XTR\TaskInterface;
use Xibo\XTR\TaskTrait;

class CustomTask implements TaskInterface
{
    use TaskTrait;

    public function setFactories($container)
    {
        return $this;
    }

    public function run()
    {
        // Retrieve options set on registering task 
        $option = $this->getOption('option1', 'defaultValue');

        // Log level had to to be set to "Debug" to be shown in logs 
        $this->log->debug('Runnig Custom Task with option1 ='. $option);

        ...
        $this->appendRunMessage('Task Completed');
    }
}
```

If you are running Xibo in development environment (i.e with CMS_DEV_MODE=true), Cron Task can be not running and Task could be executed with 
```sh
docker exec <container_id> php /var/www/cms/bin/run.php <task_id>
```
