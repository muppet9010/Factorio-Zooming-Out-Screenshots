local Gui = {}


function Gui.GuiClickedEvent(eventData)
    local player = game.players[eventData.player_index]
    local clickedElement = eventData.element
    if clickedElement.name == "zooming-screenshot-mod-button" then Gui.ToggleGui(player)
    elseif clickedElement.name == "close-zooming-screenshot-gui-button" then Gui.CloseGui(player)
    elseif clickedElement.name == "zooming-screenshot-take-all-button" then Gui.TakeAllScreenShots(player)
    elseif clickedElement.name == "start-zoom-test-screenshot" then Gui.TakeStartZoomTestScreenshot(player)
    elseif clickedElement.name == "end-zoom-test-screenshot" then Gui.TakeEndZoomTestScreenshot(player) end
end


function Gui.GuiTextChangedEvent(eventData)
    local editedElement = eventData.element
    local screenshotSettings = global.MOD.guiScreenshotSettings[eventData.player_index]
    if screenshotSettings[editedElement.name] ~= nil then
        screenshotSettings[editedElement.name] = editedElement.text
    end
end

function Gui.GuiSelectionStateChangedEvent(eventData)
    local editedElement = eventData.element
    local screenshotSettings = global.MOD.guiScreenshotSettings[eventData.player_index]
    if screenshotSettings[editedElement.name] ~= nil then
        screenshotSettings[editedElement.name] = editedElement.selected_index
    end
end


function Gui.RecreateModButton(player)
    local modFlow = player.gui.top["zooming-screenshot-mod-flow"]
    if modFlow then modFlow.destroy() end
    modFlow = player.gui.top.add{type="flow", name="zooming-screenshot-mod-flow", style = "zs_padded_horizontal_flow", direction = "horizontal"}
    modFlow.add{type="sprite-button", name="zooming-screenshot-mod-button", tooltip={"gui-tooltip.mod-toggle-button"}, sprite="zooming-screenshit-mod-icon", style = "zs_mod_button_sprite"}

    Gui.CloseGui(player)
end


function Gui.RecreateModButtonForAll()
    for _, player in pairs(game.players) do
        Gui.RecreateModButton(player)
    end
end


function Gui.CloseGui(player)
    local modGui = player.gui.left["zooming-screenshot-gui-flow"]
    if modGui ~= nil then modGui.destroy() end
end


function Gui.ToggleGui(player)
    if player.gui.left["zooming-screenshot-gui-flow"] == nil then
        Gui.OpenGui(player)
    else
        Gui.CloseGui(player)
    end
end


function Gui.OpenGui(player)
    local screenshotSettings = global.MOD.guiScreenshotSettings[player.index]
    Gui.CloseGui(player)
    local guiFlow = player.gui.left.add{type="flow", name="zooming-screenshot-gui-flow", style = "zs_padded_horizontal_flow", direction = "horizontal"}
    local guiFrame = guiFlow.add{type="frame", name="zooming-screenshot-gui-frame", direction="vertical", style="zs_gui_frame"}

    local optionsTable = guiFrame.add{type="table", name="zooming-screenshot-options-table", column_count = 3}

    optionsTable.add{type="label", name="zooming-screenshot-start-zoom-label", caption={"gui-caption.start-zoom"}, tooltip={"gui-tooltip.start-zoom"}}
    optionsTable.add{type="textfield", name="zooming-screenshot-start-zoom", text=screenshotSettings["zooming-screenshot-start-zoom"]}
    optionsTable.add{type="button", name="zooming-screenshot-start-zoom-test-screenshot", caption={"gui-caption.start-zoom-test-screenshot"}, tooltip={"gui-tooltip.start-zoom-test-screenshot"}, style = "zs_small_button"}

    optionsTable.add{type="label", name="zooming-screenshot-end-zoom-label", caption={"gui-caption.end-zoom"}, tooltip={"gui-tooltip.end-zoom"}}
    optionsTable.add{type="textfield", name="zooming-screenshot-end-zoom", text=screenshotSettings["zooming-screenshot-end-zoom"]}
    optionsTable.add{type="button", name="zooming-screenshot-end-zoom-test-screenshot", caption={"gui-caption.end-zoom-test-screenshot"}, tooltip={"gui-tooltip.end-zoom-test-screenshot"}, style = "zs_small_button"}

    optionsTable.add{type="label", name="zooming-screenshot-count-label", caption={"gui-caption.screenshot-count"}, tooltip={"gui-tooltip.screenshot-count"}}
    optionsTable.add{type="textfield", name="zooming-screenshot-count", text=screenshotSettings["zooming-screenshot-count"]}
    optionsTable.add{type="label", name="zooming-screenshot-count-padder"}

    local spacer = optionsTable.add{type="label", name="zooming-screenshot-spacer1"}
    spacer.style.height = 10
    optionsTable.add{type="label", name="zooming-screenshot-spacer2"}
    optionsTable.add{type="label", name="zooming-screenshot-spacer3"}

    optionsTable.add{type="label", name="zooming-screenshot-resolution-label", caption={"gui-caption.resolution"}, tooltip={"gui-tooltip.resolution"}}
    local resolutionFlow = optionsTable.add{type="flow", name="zooming-screenshot-resolution-flow", direction="horizontal"}
    resolutionFlow.style.width = 150
    local resolutionXInput = resolutionFlow.add{type="textfield", name="zooming-screenshot-resolution-x", text=screenshotSettings["zooming-screenshot-resolution-x"], caption={"gui-caption.resolution-x"}}
    resolutionXInput.style.width = 70
    local resolutionRightFlow = resolutionFlow.add{type="flow", name="zooming-screenshot-resolution-flow-right", direction="horizontal"}
    resolutionRightFlow.style.align="right"
    resolutionRightFlow.style.horizontally_stretchable = true
    local resolutionYInput = resolutionRightFlow.add{type="textfield", name="zooming-screenshot-resolution-y", text=screenshotSettings["zooming-screenshot-resolution-y"], caption={"gui-caption.resolution-x"}}
    resolutionYInput.style.width = 70
    optionsTable.add{type="label", name="zooming-screenshot-resolution-padder"}

    optionsTable.add{type="label", name="zooming-screenshot-show-gui-label", caption={"gui-caption.show-gui"}, tooltip={"gui-tooltip.show-gui"}}
    optionsTable.add{type="drop-down", name="zooming-screenshot-show-gui", items={"Yes", "No"}, selected_index=screenshotSettings["zooming-screenshot-show-gui"]}
    optionsTable.add{type="label", name="zooming-screenshot-show-gui-padder"}

    optionsTable.add{type="label", name="zooming-screenshot-show-entity-info-label", caption={"gui-caption.show-entity-info"}, tooltip={"gui-tooltip.show-entity-info"}}
    optionsTable.add{type="drop-down", name="zooming-screenshot-show-entity-info", items={"Yes", "No"}, selected_index=screenshotSettings["zooming-screenshot-show-entity-info"]}
    optionsTable.add{type="label", name="zooming-screenshot-show-entity-info-padder"}

    optionsTable.add{type="label", name="zooming-screenshot-anti-alias-label", caption={"gui-caption.anti-alias"}, tooltip={"gui-tooltip.anti-alias"}}
    optionsTable.add{type="drop-down", name="zooming-screenshot-anti-alias", items={"Yes", "No"}, selected_index=screenshotSettings["zooming-screenshot-anti-alias"]}
    optionsTable.add{type="label", name="zooming-screenshot-anti-alias-padder"}

    local bottomSection = guiFrame.add{type="flow", name="zooming-screenshot-bottom-section", direction="horizontal"}
    bottomSection.style.top_padding = 4
    bottomSection.add{type="button", name="close-zooming-screenshot-gui-button", caption={"gui-caption.close-gui-button"}}
    local bottomSectionRightFlow = bottomSection.add{type="flow", name="zooming-screenshot-bottom-section-right-flow"}
    bottomSectionRightFlow.style.horizontally_stretchable = true
    bottomSectionRightFlow.style.align = "right"
    bottomSectionRightFlow.add{type="button", name="zooming-screenshot-take-all-button", caption={"gui-caption.take-all-screenshots-button"}}
end


function Gui.TakeAllScreenShots(player)
    Gui.CloseGui(player)
    local screenshotSettings = global.MOD.guiScreenshotSettings[player.index]
    local startZoom = screenshotSettings["zooming-screenshot-start-zoom"]
    local endZoom = screenshotSettings["zooming-screenshot-end-zoom"]
    local screenshotCount = screenshotSettings["zooming-screenshot-count"]
    local dividedValue = endZoom/startZoom
    local naturalLog = math.log(dividedValue)
    local decay = naturalLog/(screenshotCount-1)
    local zoomDevider = 1 + decay

    local zoom = startZoom
    for shotCount=1, screenshotCount do
        Gui.TakeScreenshot(player, zoom, "ZoomingScreenshot_" .. shotCount)
        zoom = zoom * zoomDevider
    end
end


function Gui.TakeStartZoomTestScreenshot(player)
    local zoom = global.MOD.guiScreenshotSettings[player.index]["zooming-screenshot-start-zoom"]
    Gui.TakeScreenshot(player, zoom, "Start_Zoom_" .. zoom)
end


function Gui.TakeEndZoomTestScreenshot(player)
    local zoom = global.MOD.guiScreenshotSettings[player.index]["zooming-screenshot-end-zoom"]
    Gui.TakeScreenshot(player, zoom, "End_Zoom_" .. zoom)
end


function Gui.TakeScreenshot(player, zoom, name)
    local screenshotSettings = global.MOD.guiScreenshotSettings[player.index]
    local screenshotPosition = {x=player.position.x, y = player.position.y-0.6}
    game.take_screenshot{
        position = screenshotPosition,
        resolution = {
            x = screenshotSettings["zooming-screenshot-resolution-x"],
            y = screenshotSettings["zooming-screenshot-resolution-y"]
        },
        zoom = zoom,
        show_gui = Gui.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-show-gui"]),
        show_entity_info = Gui.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-show-entity-info"]),
        anti_alias = Gui.BooleanDropdownIndexToBool(screenshotSettings["zooming-screenshot-anti-alias"]),
        path=name..".png"
    }
end


function Gui.BooleanDropdownIndexToBool(value)
    if value == 1 then return true
    elseif value == 2 then return false
    else return nil end
end

return Gui
