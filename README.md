# Factorio-Zooming-Out-Screenshots

Takes a series of screenshots steadily zooming out from the player's location. Configurable start and end zoom levels plus the number of screenshots to take between them via simple GUI. Zooms out at an auto-calculated rate of decay (exponential). Designed for creating zooming out videos or montages. The mod isn't 100% accurate on the final zoom level see notes, but is close enough.

Standard screenshot options are exposed in the GUI: resolution, show the GUI, show entity info (alt-mode), anti-aliasing.
Screenshots are saved to the player's script-output folder in the format "ZoomingScreenshot_NUMBER" starting at number 1 for the Start Zoom level.

The Test End Zoom screenshot is just an indication of the final zoom level. There is a rounding error that will cause the last screenshots to be very slightly zoomed out more than the test one.
If doing less than 50~ screenshots the algorithm may not zoom out to the End Zoom setting.
The idea of the auto-calculating zoom is to ensure you have the required number of images for the video frames and that they zoom out progressively.

This mod does not support multiple players at present. If required please request.

When taking screenshots the game will pause for a while (seconds to minutes) based on the number of screenshots and resolution. This is standard Factorio behaviour and so it is advised to use this mod only on local games to avoid disconnects.
There are some oddities with taking screenshots and certain setting combinations, all of these apply equally to this mod, i.e. enabling GUI and using a resolution different to your display resolution.
