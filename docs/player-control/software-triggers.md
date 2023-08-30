---
nav: "player-control"
slug: "player-control/software-triggers"
alias: "software-triggers-using-the-api"
title: "Software Triggers through XMR - Player Control"
---

# Software Triggers through XMR

Xibo supports dynamic signage through the use of software triggers. These are triggers initiated by the CMS and pushed to targeted Players for immediate action using the Xibo Message Relay (XMR), a form of push messaging. Software triggers are a flexible way to connect Xibo Players to devices or software which are centrally available to the CMS.

Software triggers through XMR are only available if the network connected.



>  If the device or software is available at the player, then web hooks may be a better approach to integration. We sometimes refer to web hooks as hardware triggers, because they happen at the player rather than at the CMS.



Software triggers are initiated via the CMS API and in some cases via menu items in the user interface.



## Triggers

A range of actions are supported by the CMS:

| Action           | Description                                                  | Params                                                       | Available in                            |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------------------------------- |
| changeLayout     | Immediately change to the specified Layout                   | `layoutId`, `duration`, `downloadRequired`, `changeMode`<br /><br />The `changeMode` parameter can be either "replace" or "queue", where the value effects the currently active changeLayout actions. The `duration` is always based on the time since the message was received, even when in "queue" mode. | API                                     |
| collectNow       | Run XMDS routine collection immediately                      |                                                              | API, Display Page and Schedule Update.  |
| commandAction    | Run a configured Command                                     | `commandCode`                                                | API and Display Page                    |
| overlayLayout    | Immediately overlay a Layout                                 | `layoutId`, `duration`, `downloadRequired`                   | API                                     |
| rekeyAction      | Regenerate the Player Public Key and Channel                 |                                                              | API and auto send via with Display Edit |
| revertToSchedule | Revert to the scheduled content, removing any Layouts/Overlays |                                                            | API                                     |
| screenShot       | Take and send a screen shot                                  |                                                              | API and Display Page                    |
| triggerWebhook   | Trigger a web hook to be simulated on the Player             | `triggerCode`                                                | API and Display Page                    |
| purgeAll         | Remove all downloaded Media files from local storage and request fresh copies |                                             | API and Display Page                    |


## Security

Triggers are sent over TCP and therefore security is an understandable concern for many users. To maintain Xibo's high standards in this area the push messages we send only contain instructions to communicate with the CMS or show existing content already held by the Player (for example existing Layouts, existing Commands, etc).

Messages are also sealed with a RSA public key - the private counterpart being held by the Player. The Player sends the public key to the CMS, and the CMS will seal all messages destined for that particular player with the public key provided. The player must then verify the sealed message to ensure it originates from the CMS.



## Example

A popular example of using software triggers is for emergency messaging. Typically emergency messages are fed from a 3rd party system to the CMS and then triggers are sent via XMR push messaging to Xibo Players. The 3rd party system integrates with the Xibo API for maximum responsiveness - as soon as they have a message to be sent, they execute an API request, which in turn executes push messaging and updates the Display.