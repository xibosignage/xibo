---
nav: "widgets"
slug: "widgets/widget-sizing"
alias: "widget-sizing-how-does-it-work"
title: "Widget Sizing - Widgets"
---

# Widget Sizing

Most Widgets in Xibo scale themselves according to their containing Region's dimensions, but there are some exceptions and some Widgets which take special extra measures to get themselves just right.

There are 3 methods:
 - Library Media - aspect or stretch
 - Size to Region
 - Fit to Region

Widgets provide one scaling option, except the Web Page Widget which has its own options for controlling size/position of the hosted Web Page.

## Library Media
Library Media, such as images or video, are always either scaled to the Region size by their aspect ratio, or they are stretched to fit the whole Region.

If the Media does not fit exactly when scaled, it will be positioned centrally in the Region and the sides will be transparent (allowing whatever is underneath to show through).

## Size to Region
This is the normal operation for most non-Library Widgets, such as Text or Embedded. In this case the content in the Widget is sized according to the Region dimensions and then scaled up/down proportionally when viewed.

This is achieved using a CSS `transform`, type `scale`, and effectively can be viewed as zooming in or out.

All aspects of the Layout Designer are scaled out to represent the smaller size of the Designer window when compared to the Layout/Regions actual dimensions.

If you design a 1920x1080 Layout and run it on a 1920x1080 Display, no scaling will occur.

The most obvious way to see this in action is to add a Text Widget and set a font size. You will notice that the size you pick always looks smaller than you might expect. This is because the Layout Designer is scaled out, so that you can see how that font will look on screen in relation to the other Widgets in the Layout.

## Fit to Region
This is the normal operation for more complicated widgets such as Twitter/Weather. These Widgets usually provide pre-defined templates, and when you override those templates to make adjustments you see an "Original Width" and "Original Height" option.

These options set the dimensions for your HTML/CSS, regardless of the Region size. You can make your template look beautiful at a set width/height, drop it in a Region with different dimensions and the Fit to Region scaler will treat it like an Image and fit it in the Region according to its aspect ratio.

For example, the Weather Template 5 is a Portrait template which when dropped in a Landscape Region will fit itself nicely to the Height and centre itself horizontally in the Region.

We do this by setting an absolute width/height on the container, before applying the "Size to Region" scaling mode.

Editing the Template and removing the HTML/CSS, or the container we've provided disables this Fit to Region functionality and we will just apply the "Size to Region" instead.