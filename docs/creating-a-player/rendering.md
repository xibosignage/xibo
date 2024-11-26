---
nav: "creating-a-player"
slug: "creating-a-player/rendering"
title: "Rendering - Creating a Player"
excerpt: "The Media node in the XLF attempts to tell the Player how it should be played using the type and render attributes."
---

# Rendering

The Media node in the XLF attempts to tell the Player how it should be played using the `type` and `render` attributes. The render attribute can either be `native` or `html` and the type attribute is set to the type of Widget the Media node represents.

HTML render mode means that the CMS will provide a `html` file via `GetResource` which the Player can open in an embedded browser (at the appropriate size) to render the Media. 

Native render mode means that the Player is entirely responsible for rendering that Media and the CMS does not provide a resource to assist.

Most types of core Media and any custom Media will be `html` render mode. Some media items are set to render `native` but can actually be rendered in `html` at the discretion of the implementer - these are mostly cases where the Media is set to `native` for backwards compatibility. If you are implementing a new Player then it is safest to use `html` where possible.

Some examples of what you might expect (this list is not exhaustive):

| Render               | Type                                                         |
| -------------------- | ------------------------------------------------------------ |
| native               | image, video, powerpoint, flash, audio, localvideo, shell command |
| html                 | twitter, forecastio, clock                                   |
| native (can be html) | embedded, text, ticker, webpage, datasetview                 |

Typically `native` Media is a type that would benefit or require a deeper integration with the underlying hardware.

How the HTML files for `html` render arrive at the Player is discussed below.



### Duration

Each Media item represented in the XLF has a duration in seconds attribute. This represents the total time the Player should show that item before moving on to the next. The Player should show a Media item for the time specificed in the `duration` attribute.

A Region is considered "expired" when all Media has been shown for its duration, and a Layout is expired when all Regions are expired. This means that a Layout is shown for the duration of the longest set of media.

HTML rendered Media sometimes provides additional data in the HTML, which is used to adjust the duration of the media item. This happens when it is *impossible* for the XLF to know how long the Media will be shown before it is rendered - a good example is when a Ticker has "duration is per item" selected, as this then depends on the number of items.

These options are provided in the HTML file as comments which can be parsed by the Player and used to adjust the duration of the Media accordingly. They are:

- `<!-- NUMITEMS=X -->`: Informational tag containing the number of items in the resource.
- `<!-- DURATION=X -->`: Calculated total duration for this media item.

Following in this section are some notes specific to certain core Modules. These are either native modules or html modules that require specific handling.



## HTML render - GetResource

Media using `html` rendering should load the HTML file provided by XMDS during the GetResource call. This file is designed to render according to the original design size and scale appropriately. It should be opened in a transparent Web Browser unless otherwise stated by a `transparency` option.

HTML resources are downloaded during the usual XMDS "Required Files" process, where they are kept in date by the `updated` attribute. However it is also common place for the Media rendering itself to call `GetResource` if it thinks that the cached resource of out of date.

An `updateInterval` option is provided on most Media types to support this functionality. When rendering Media the Player should compare the last write time of the HTML file with the `updateInterval` option if one is present. If so, a new copy of the HTML should be downloaded from XMDS. This process shouldn't  effect the timely rendering of the Media and it could be that it queues the downloaded to happen in the background, so that it is ready for the next time the Media is shown.



## Image

Images are library items and will be transferred to the Player via `RequiredFiles`. By default the CMS allows JPG, PNG, GIF and BMP images to be uploaded. Image media nodes contain the `uri` option which matches the `path` attribute provided in `Required Files`. The Player should use this to locate the cached file.

The Player is responsible for natively rendering images according to the following options:

 - scaleType: Either center or stretch.
 - align: Either left, center or right.
 - valign: Either top, middle or bottom.




## Video

Videos are library items and will be transferred to the Player via `RequiredFiles`. By default the CMS allows WMV, AVI, MP4 and WEBM videos to be uploaded. Video media nodes contain the `uri` option which matches the `path` attribute provided in `Required Files`. The Player should use this to locate the cached file.

The Player is responsible for natively rendering videos according to the following options:

 - loop: Play the video for its full duration and loop if it finishes before the duration is reached.
 - mute: Mute the video.

#### Loop

The loop setting is only applicable if the duration has been specified and is not 0 (end-detect). Duration always specifies the total duration for the media item, which means the loop setting can be used to play a shorter video in a loop for a set period of time, without any gap between playback.

For example, a 10 second video with duration set to 60 seconds and set to loop will play through 6 times before moving on to the next media in the list.

### Duration

Videos can have a special duration attribute of "0" which means "end detect". This allows the user to assign a video widget to the Layout without having to assess its duration. When a duration of 0 is provided it is the Players responsibility to detect when that video has completed and advance to the next item.

When a duration of 0 is provided the `loop` option should be ignored.



## Local Video

The local video module is very similar to the video module except that the file is not provided by `RequiredFiles`. Local Video is used either when the file is provided to the player by another means or when the video should be streamed.

In both cases the `uri` option is the path to the video file.



## Flash and PowerPoint

Flash and PowerPoint have limited support on the Windows Player and rely on the underlying application being available. If the Player does not have PowerPoint or Flash installed the Layout should be skipped.

They are both library items transferred to the Player via `RequiredFiles`.

There are no additional options with these widgets.



## Web Page

Web Page widgets provide rendered HTML via `GetResource`. However they also provide a `modeId` option which is used to determine whether the web page should be opened directly in the embedded web browser or via the rendered HTML.

When the `modeId` is equal to 1 the Player should parse the `url` option and open that directly in a web view.



## Embedded

Embedded widgets provide rendered HTML via `GetResource`. They also provide a `transparency` option which is used to determine if the web view should be transparent.



## Shell Commands

The Shell Command widget exists to execute Shell Commands on a Layout. It provides three options:

 - commandCode
 - windowsCommand
 - linuxCommand

Pre-defined commands can be used which have been configured as per the [command functionality](displays_commands.html). The player should inspect the command configuration
it received during the [`RegisterDisplay`](xmds.html#RegisterDisplay) XMDS call for the command string to execute.

An adhoc command does not have a commandCode and instead provides a windows/linux Command to execute. It is the players responsibility to sanitize and execute these commands in a Shell.



## Audio

Audio files are library items and will be transferred to the Player via `RequiredFiles`. The player is responsible for natively rendering these files in an appropriate media player. They will have a `loop` and `volume` option.

#### Child Audio

Audio can also be added to another Media item - for example a text item - in order to play a sound while the parent item is being shown. Zero or more audio items can be added to a media item.

When the parent media item finishes the child must also finish, even if it hasn't played completely through.



# Transitions

Transitions are a concept used to describe how a Media item should be put on and taken off the screen.

There are places the XLF can contain transitions:

- Region Exit Transitions in Region options
- Playlist Transitions in Media options

The Region Exit transition describes the transition to run when the region has finished completely and will be removed (this is different from when the region has expired). It runs in place of the `transOut` transition on the Widget being shown at the time the Region ends. All Regions Exit transitions run at the same time and describe how the Layout moves off screen.

The Playlist transition describes a `transIn` and `transOut` on each Media item, decribing how that media item comes onto screen and leaves screen.

Example Media:

```xml
<transIn></transIn>
<transInDuration></transInDuration>
<transInDirection></transInDirection>
<transOut></transOut>
<transOutDuration></transOutDuration>
<transOutDirection></transOutDirection>
```



Example Region:

```xml
<transitionType></transitionType>
<transitionDuration></transitionDuration>
<transitionDirection></transitionDirection>
```



The transition type can be:

- `fadeIn`: only used for In
- `fadeOut`: only used for Out
- `fly`: can be used for In and Out

The transition duration is measured in milliseconds and in the case of `fly` the direction is a compass point: `N, NE, E, SE, S, SW, W, NW`.

The media duration should **include** the `in` transition but exclude the `out` transition.
