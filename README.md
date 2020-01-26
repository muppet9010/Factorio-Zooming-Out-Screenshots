# Factorio-Zooming-Out-Screenshots

Takes a series of screenshots steadily zooming out from the player's location. Configurable start and target end zoom levels plus the number of screenshots to take between them via simple GUI. Zooms out at an auto-calculated rate of decay (exponential). Designed for creating zooming out videos or montages. The mod isn't 100% accurate on the final zoom level see notes, but is close enough.

Minimum Factorio final zoom value is 0.04 in reality since Factorio 0.18. This is restricted and forced in a slightly clunky way at present within the mod. If there's demand this mod will get refreshed.

Example Screenshot Montage made to Video
![Example Screenshot Montage made to Video](https://media.giphy.com/media/kWFmXsGmysEnTUkCSm/giphy.gif)

Standard screenshot options are exposed in the GUI: resolution, show the GUI, show entity info (alt-mode), anti-aliasing.
Screenshots are saved to the player's script-output folder in the format "ZoomingScreenshot_NUMBER" starting at number 1 for the Start Zoom level. Output files are all in the .png file type to esnure quality.

The Test End Zoom screenshot is just an indication of the final zoom level. There is a rounding error that will cause the last screenshots to be slightly zoomed out more than the specified target, but they will match the teset screenshot.
If doing less than 50~ screenshots the algorithm may not zoom out to the End Zoom setting.
The idea of the auto-calculating zoom is to ensure you have the required number of images for the video frames and that they zoom out progressively. For this reason the round error in Lua can't be corrected.

When taking screenshots the game will pause for a while (seconds to minutes) based on the number of screenshot, resolution and zoom. This is standard Factorio behaviour and so it is advised to use this mod only on local games to avoid disconnects. In extreme cases, the game may run out of memory and crash or may hang for so long that windows kills it.
There are some oddities with taking screenshots and certain setting combinations, all of these apply equally to this mod, i.e. enabling GUI and using a resolution different to your display resolution.
