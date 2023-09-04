---
nav: "player-control"
slug: "player-control/webhooks"
title: "Webhooks - Player Control"
---

# Webhooks

Using the interactive control library it is possible to [send a web hook](https://github.com/xibosignage/xibo-interactive-control#trigger-actionweb-hook) to the Player. Any incoming web hook will be tested against the currently running Actions which have been configured on the current Layout or Schedule. If a match is found, the web hook Action will be executed and the corresponding Action taken.

The default configuration is to only allow web hooks incoming on `localhost`, effectively securing them only for use by Widgets. However an external system needs to call a web hook, one or more Displays can be configured to allow WAN connections to their web server in the Display Settings Profile.



### Trigger Code

All web hooks must supply a `trigger` parameter which will be matched against the "Trigger Code" of any configured Actions.



### Running commands

A particularly powerful usage of this mechanism is to have a Shell Command widget in your drawer, and use a Navigate to Widget Action, targeted to the Screen. This will execute the specified command without effecting other playback.

This functionality can be used to have an incoming web hook trigger another series of actions.