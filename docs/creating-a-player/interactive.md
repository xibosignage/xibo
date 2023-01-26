---
nav: "creating-a-player"
slug: "creating-a-player/interactive"
title: "Interactive - Creating a Player"

---

# Interactive

The interactive feature is available from Xibo v3 and all v3 players should support interactivity where practical. Interactivity is not just touch/click, it also includes web hooks.

## Parsing

Each time a Layout is loaded its actions should be [parsed from the XLF](xlf#content-actions).

#### Action Types

The following action types are available:

- `next`: Next Layout or Widget
- `previous`: Previous Layout or Widget
- `navLayout`: Navigate to a Layout
- `navWidget`: Navigate to a Widget. If the target is `screen` then expect a shell command to execute.



### Drawer

The drawer is a collection of Widgets with a similar structure to a normal Region. Widgets in the Drawer are referenced by Actions elsewhere in the Layout. The Drawer is not shown directly.



## Listening

There are two ways an action is triggered:

- Touch/Click
- Web hook

Once a trigger is received via either method, it should be compared against the currently active actions and their triggers. If the trigger received matches an Action, it should be processed. For example, if a touch event is received which occurred within the boundary of the player window, its coordinates should be passed through to the list of actions and compared. If there is an action which matches those coordinates, and matches the source of that action, then it would be processed.

Players should monitor click/touch events and their embedded web servers for incoming `/trigger` POST requests containing a trigger code and optional source `widgetId`. When either event is detected the player should compare the trigger with the Actions parsed out of the current schedule/layout. If any actions match they should be executed.

When the action is loaded it should run for its whole duration and on expiry the player should reload its previous state. If a Layout has been loaded its previous state would be the start of the prior Layout. If a Widget has been loaded its previous state would be the prior widget in that region.



#### Web hooks

Web hooks can be triggered by:

- a third party calling the local web server
- a widget using [xiboIC](https://github.com/xibosignage/xibo-interactive-control)

The post both for a generic trigger:

```json
{
	id: id,
    trigger: code
}
```

Special triggers:

- expireNow: this expires a widget immediately (`/duration/expire`)
- extendWidgetDuration: this extends the duration of a widget by the specified value (`/duration/extend`)
- setWidgetDuration: this sets the duration of a widget to the specified value (`/duration/set`)

```json
{
    id: id,
    duration: duration
}
```

In all cases the `id` is the widgetId of the calling widget, which is compared to the `sourceId` of the action.



## Example XLF

Below is an example of a Layout with a title bar at the top, a main region to the left and 3 touch regions to the right. In the 3 touch regions there is a Next/Prev button and a Navigate to Widget button. The Widget loaded by the Navigate to Widget button also has an action on it, which is to load a new Layout.

```xml
<layout width="1080" height="1920" bgcolor="#0b1d6f" schemaVersion="3" enableStat="1">
   <region id="3364" width="1080" height="350" top="0" left="0">
      <options />
      <media id="6262" type="text" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1">
         <options />
         <raw />
      </media>
   </region>
   <region id="3365" width="882.35" height="1568.14" top="349.94" left="0">
      <options />
      <media id="6263" type="image" render="native" duration="300" useDuration="1" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="128440">
         <options />
         <raw />
      </media>
      <media id="6264" type="image" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="128362">
         <options />
         <raw />
      </media>
      <media id="6265" type="image" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="128203">
         <options />
         <raw />
      </media>
      <media id="6266" type="image" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="934">
         <options />
         <raw />
      </media>
      <media id="6267" type="image" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="935">
         <options />
         <raw />
      </media>
      <media id="6268" type="image" render="native" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1" fileId="933">
         <options />
         <raw />
      </media>
   </region>
   <region id="3366" width="204.04" height="211.71" top="430.83" left="875.94">
      <options />
      <media id="6269" type="text" render="native" duration="1" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1">
         <action layoutCode="" widgetId="" targetId="3365" target="region" sourceId="6269" source="widget" actionType="next" triggerType="touch" triggerCode="" id="181" />
         <options />
         <raw />
      </media>
   </region>
   <region id="3367" width="199.14" height="203.38" top="1400.22" left="880.17">
      <options />
      <media id="6270" type="text" render="native" duration="1" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1">
         <action layoutCode="" widgetId="" targetId="3365" target="region" sourceId="6270" source="widget" actionType="previous" triggerType="touch" triggerCode="" id="182" />
         <options />
         <raw />
      </media>
   </region>
   <region id="3368" width="199.87" height="228.57" top="909.14" left="880.1">
      <options />
      <media id="6271" type="text" render="native" duration="1" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1">
         <action layoutCode="" widgetId="6272" targetId="3365" target="region" sourceId="6271" source="widget" actionType="navWidget" triggerType="touch" triggerCode="" id="183" />
         <options />
         <raw />
      </media>
   </region>
   <drawer id="3369" width="1080" height="1920" top="0" left="0">
      <options />
      <media id="6272" type="forecastio" render="html" duration="10" useDuration="0" fromDt="1970-01-01 01:00:00" toDt="2038-01-19 03:14:07" enableStat="1">
         <action layoutCode="ADSPACE_IMAGE_PORTRAIT" widgetId="" targetId="" target="screen" sourceId="6272" source="widget" actionType="navLayout" triggerType="touch" triggerCode="" id="184" />
         <options />
         <raw />
      </media>
   </drawer>
   <tags />
</layout>
```

