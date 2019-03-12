local Screenshot = {}


function Screenshot.CalculateZoomDetails(player)
    local screenshotSettings = global.MOD.guiScreenshotSettings[player.index]
    local startZoom = screenshotSettings["zooming-screenshot-start-zoom"]
    local targetEndZoom = screenshotSettings["zooming-screenshot-end-zoom"]
    local screenshotCount = screenshotSettings["zooming-screenshot-count"]
    local dividedValue = targetEndZoom/startZoom
    local naturalLog = math.log(dividedValue)
    local decay = naturalLog/(screenshotCount-1)
    local zoomDevider = 1 + decay
    return {zoomDevider=zoomDevider, screenshotCount=screenshotCount, startZoom=startZoom, targetEndZoom=targetEndZoom}
end


function Screenshot.TakeScheduledScreenshots(player)
    script.on_nth_tick(game.tick, nil)
    if not player.valid then return end
    local zoomDetails = Screenshot.CalculateZoomDetails(player)
    local zoom = zoomDetails.startZoom
    for shotCount=1, zoomDetails.screenshotCount do
        Screenshot.TakeScreenshot(player, zoom, "ZoomingScreenshot_" .. shotCount)
        zoom = zoom * zoomDetails.zoomDevider
    end
end


function Screenshot.TakeAllScreenShots(player)
    local triggerTick = game.tick + 1
    script.on_nth_tick(triggerTick, function() Screenshot.TakeScheduledScreenshots(player) end)
end


function Screenshot.TakeStartZoomTestScreenshot(player)
    local zoomDetails = Screenshot.CalculateZoomDetails(player)
    Screenshot.TakeScreenshot(player, zoomDetails.startZoom, "Start_Zoom_" .. zoomDetails.startZoom)
end


function Screenshot.TakeEndZoomTestScreenshot(player)
    local zoomDetails = Screenshot.CalculateZoomDetails(player)
    local zoom = zoomDetails.startZoom
    for i=1, zoomDetails.screenshotCount-1 do
        zoom = zoom * zoomDetails.zoomDevider
    end
    Screenshot.TakeScreenshot(player, zoom, "End_Zoom_" .. zoomDetails.targetEndZoom)
end


function Screenshot.TakeScreenshot(player, zoom, name)
    local screenshotSettings = global.MOD.guiScreenshotSettings[player.index]
    local screenshotPosition = {x=player.position.x, y = player.position.y-0.6}
    game.take_screenshot{
        by_player = player,
        position = screenshotPosition,
        resolution = {
            x = screenshotSettings["zooming-screenshot-resolution-x"],
            y = screenshotSettings["zooming-screenshot-resolution-y"]
        },
        zoom = zoom,
        show_gui = Screenshot.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-show-gui"]),
        show_entity_info = Screenshot.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-show-entity-info"]),
        anti_alias = Screenshot.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-anti-alias"]),
        path=name..".png"
    }
end


function Screenshot.BooleanDropdownIndexToBool(value)
    if value == 1 then return true
    elseif value == 2 then return false
    else return nil end
end


return Screenshot