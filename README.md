# Factorio-Zooming-Out-Screenshots

Takes a series of screenshots steadily zooming out from the player's location.
![Example Screenshot Montage made to Video](https://media.giphy.com/media/kWFmXsGmysEnTUkCSm/giphy.gif)

Features
=========

- Configurable start and target end zoom levels.
- Configurable number of screenshots to take between zoom levels.
- Zooms out at an auto-calculated rate of decay (exponential). Designed for creating zooming out videos or montages.
- Standard screenshot options are exposed in the GUI: resolution, show the GUI, show entity info (alt-mode), anti-aliasing.
- Quick test screenshot option to get single images at the specified zoom level quickly.

Notes
=========

- Minimum Factorio final zoom value is 0.04 since Factorio 0.18, enforced by the mod.
- Screenshots are saved to the player's script-output folder in the format "ZoomingScreenshot_NUMBER" starting at number 1 for the Start Zoom level. Output files are all in the .png file type to ensure quality.
- The Test End Zoom screenshot is just an indication of the final zoom level. There is a rounding error that will cause the last screenshots to be slightly zoomed out more than the specified target, but they will match the test screenshot.
- If doing less than 50~ screenshots the zoom algorithm may not zoom out quite to the End Zoom setting, but will be very close.

Usage Warning
=========

When taking screenshots the game will pause for a while (seconds to minutes) based on the number of screenshot, resolution and zoom. This is standard Factorio behaviour and so it is advised to use this mod only on local games to avoid multiplayer disconnects. In extreme cases, the game may run out of memory and crash or may hang for so long that windows kills it (varies between pcs)

There are some oddities with taking screenshots and certain setting combinations within Factorio. All of these apply equally to this mod.  Fir example; enabling GUI and using a resolution different to your display resolution will create a mis aligned image.
