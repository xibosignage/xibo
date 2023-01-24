---
nav: "player-control"
slug: "player-control/controlling-duration"
title: "Controlling Widget Duration - Player Control"
---

# Controlling Widget Duration

Using the interactive control library it is possible to [expire, extend or set the duration](https://github.com/xibosignage/xibo-interactive-control#expire) of any Widget on the current Layout. Xibo itself uses this mechanism to implement "duration per page" on the PDF Widget, because the number of pages in the PDF is unknown until the point it loads, so it is impossible to calculate the overall Widget duration until run time.

Similarly this functionality is useful for any Widget which wants to control its own life cycle.