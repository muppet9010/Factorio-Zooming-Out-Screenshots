local Screenshot = require("screenshot")
local Gui = {}

function Gui.GenerateDefaultSettings(playerID)
    if global.MOD.guiScreenshotSettings[playerID] == nil then
        global.MOD.guiScreenshotSettings[playerID] = {}
    end
    local guiScreenshotSettings = global.MOD.guiScreenshotSettings[playerID]
    if guiScreenshotSettings["zooming-screenshot-start-zoom"] == nil then
        guiScreenshotSettings["zooming-screenshot-start-zoom"] = 20
    end
    if guiScreenshotSettings["zooming-screenshot-end-zoom"] == nil then
        guiScreenshotSettings["zooming-screenshot-end-zoom"] = 0.125
    end
    if guiScreenshotSettings["zooming-screenshot-count"] == nil then
        guiScreenshotSettings["zooming-screenshot-count"] = 100
    end
    if guiScreenshotSettings["zooming-screenshot-resolution-x"] == nil then
        guiScreenshotSettings["zooming-screenshot-resolution-x"] = 1024
    end
    if guiScreenshotSettings["zooming-screenshot-resolution-y"] == nil then
        guiScreenshotSettings["zooming-screenshot-resolution-y"] = 765
    end
    if guiScreenshotSettings["zooming-screenshot-show-gui"] == nil then
        guiScreenshotSettings["zooming-screenshot-show-gui"] = 2
    end
    if guiScreenshotSettings["zooming-screenshot-show-entity-info"] == nil then
        guiScreenshotSettings["zooming-screenshot-show-entity-info"] = 2
    end
    if guiScreenshotSettings["zooming-screenshot-anti-alias"] == nil then
        guiScreenshotSettings["zooming-screenshot-anti-alias"] = 2
    end
end

function Gui.GenerateDefaultSettingsForAll()
    for _, player in pairs(game.players) do
        Gui.GenerateDefaultSettings(player.index)
    end
end

function Gui.GuiClickedEvent(eventData)
    local player = game.get_player(eventData.player_index)
    local clickedElement = eventData.element
    if clickedElement.name == "close-zooming-screenshot-gui-button" then
        Gui.CloseGui(player)
    elseif clickedElement.name == "zooming-screenshot-take-all-button" then
        Gui.TakeAllScreenShots(player)
    elseif clickedElement.name == "zooming-screenshot-start-zoom-test-screenshot" then
        Screenshot.TakeStartZoomTestScreenshot(player)
    elseif clickedElement.name == "zooming-screenshot-end-zoom-test-screenshot" then
        Screenshot.TakeEndZoomTestScreenshot(player)
    end
end

function Gui.GuiTextChangedEvent(eventData)
    local editedElement = eventData.element
    local screenshotSettings = global.MOD.guiScreenshotSettings[eventData.player_index]
    if screenshotSettings[editedElement.name] ~= nil then
        screenshotSettings[editedElement.name] = editedElement.text
    end
    local endZoomNumber = tonumber(screenshotSettings["zooming-screenshot-end-zoom"])
    if endZoomNumber ~= nil and endZoomNumber < 0.04 then
        local player = game.get_player(eventData.player_index)
        local guiElement = player.gui.left["zooming-screenshot-gui-flow"]["zooming-screenshot-gui-frame"]["zooming-screenshot-options-table"]["zooming-screenshot-end-zoom"]
        guiElement.text = "0.04"
        screenshotSettings["zooming-screenshot-end-zoom"] = "0.04"
    end
end

function Gui.GuiSelectionStateChangedEvent(eventData)
    local editedElement = eventData.element
    local screenshotSettings = global.MOD.guiScreenshotSettings[eventData.player_index]
    if screenshotSettings[editedElement.name] ~= nil then
        screenshotSettings[editedElement.name] = editedElement.selected_index
    end
end

function Gui.ShortcutClicked(eventData)
    local shortcutName = eventData.prototype_name
    if shortcutName ~= "zooming-screenshot" then
        return
    end
    local player = game.get_player(eventData.player_index)
    Gui.ToggleGui(player)
end

function Gui.CloseGuiForAll()
    for _, player in pairs(game.players) do
        Gui.CloseGui(player)
    end
end

function Gui.CloseGui(player)
    local modGui = player.gui.left["zooming-screenshot-gui-flow"]
    if modGui ~= nil then
        modGui.destroy()
    end
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
    local guiFlow = player.gui.left.add {type = "flow", name = "zooming-screenshot-gui-flow", style = "zs_padded_horizontal_flow", direction = "horizontal"}
    local guiFrame = guiFlow.add {type = "frame", name = "zooming-screenshot-gui-frame", direction = "vertical", style = "zs_gui_frame"}

    local optionsTable = guiFrame.add {type = "table", name = "zooming-screenshot-options-table", column_count = 3}

    optionsTable.add {type = "label", name = "zooming-screenshot-start-zoom-label", caption = {"gui-caption.start-zoom"}, tooltip = {"gui-tooltip.start-zoom"}}
    optionsTable.add {type = "textfield", name = "zooming-screenshot-start-zoom", text = screenshotSettings["zooming-screenshot-start-zoom"]}
    optionsTable.add {type = "button", name = "zooming-screenshot-start-zoom-test-screenshot", caption = {"gui-caption.start-zoom-test-screenshot"}, tooltip = {"gui-tooltip.start-zoom-test-screenshot"}, style = "zs_small_button"}

    optionsTable.add {type = "label", name = "zooming-screenshot-end-zoom-label", caption = {"gui-caption.end-zoom"}, tooltip = {"gui-tooltip.end-zoom"}}
    optionsTable.add {type = "textfield", name = "zooming-screenshot-end-zoom", text = screenshotSettings["zooming-screenshot-end-zoom"]}
    optionsTable.add {type = "button", name = "zooming-screenshot-end-zoom-test-screenshot", caption = {"gui-caption.end-zoom-test-screenshot"}, tooltip = {"gui-tooltip.end-zoom-test-screenshot"}, style = "zs_small_button"}

    optionsTable.add {type = "label", name = "zooming-screenshot-count-label", caption = {"gui-caption.screenshot-count"}, tooltip = {"gui-tooltip.screenshot-count"}}
    optionsTable.add {type = "textfield", name = "zooming-screenshot-count", text = screenshotSettings["zooming-screenshot-count"]}
    optionsTable.add {type = "label", name = "zooming-screenshot-count-padder"}

    local spacer = optionsTable.add {type = "label", name = "zooming-screenshot-spacer1"}
    spacer.style.height = 10
    optionsTable.add {type = "label", name = "zooming-screenshot-spacer2"}
    optionsTable.add {type = "label", name = "zooming-screenshot-spacer3"}

    optionsTable.add {type = "label", name = "zooming-screenshot-resolution-label", caption = {"gui-caption.resolution"}, tooltip = {"gui-tooltip.resolution"}}
    local resolutionFlow = optionsTable.add {type = "flow", name = "zooming-screenshot-resolution-flow", direction = "horizontal"}
    resolutionFlow.style.width = 150
    local resolutionXInput = resolutionFlow.add {type = "textfield", name = "zooming-screenshot-resolution-x", text = screenshotSettings["zooming-screenshot-resolution-x"], tooltip = {"gui-tooltip.resolution-x"}}
    resolutionXInput.style.width = 70
    local resolutionRightFlow = resolutionFlow.add {type = "flow", name = "zooming-screenshot-resolution-flow-right", direction = "horizontal"}
    resolutionRightFlow.style.horizontal_align = "right"
    resolutionRightFlow.style.horizontally_stretchable = true
    local resolutionYInput = resolutionRightFlow.add {type = "textfield", name = "zooming-screenshot-resolution-y", text = screenshotSettings["zooming-screenshot-resolution-y"], tooltip = {"gui-tooltip.resolution-y"}}
    resolutionYInput.style.width = 70
    optionsTable.add {type = "label", name = "zooming-screenshot-resolution-padder"}

    optionsTable.add {type = "label", name = "zooming-screenshot-show-gui-label", caption = {"gui-caption.show-gui"}, tooltip = {"gui-tooltip.show-gui"}}
    optionsTable.add {type = "drop-down", name = "zooming-screenshot-show-gui", items = {"Yes", "No"}, selected_index = screenshotSettings["zooming-screenshot-show-gui"]}
    optionsTable.add {type = "label", name = "zooming-screenshot-show-gui-padder"}

    optionsTable.add {type = "label", name = "zooming-screenshot-show-entity-info-label", caption = {"gui-caption.show-entity-info"}, tooltip = {"gui-tooltip.show-entity-info"}}
    optionsTable.add {type = "drop-down", name = "zooming-screenshot-show-entity-info", items = {"Yes", "No"}, selected_index = screenshotSettings["zooming-screenshot-show-entity-info"]}
    optionsTable.add {type = "label", name = "zooming-screenshot-show-entity-info-padder"}

    optionsTable.add {type = "label", name = "zooming-screenshot-anti-alias-label", caption = {"gui-caption.anti-alias"}, tooltip = {"gui-tooltip.anti-alias"}}
    optionsTable.add {type = "drop-down", name = "zooming-screenshot-anti-alias", items = {"Yes", "No"}, selected_index = screenshotSettings["zooming-screenshot-anti-alias"]}
    optionsTable.add {type = "label", name = "zooming-screenshot-anti-alias-padder"}

    local bottomSection = guiFrame.add {type = "flow", name = "zooming-screenshot-bottom-section", direction = "horizontal"}
    bottomSection.style.top_padding = 4
    bottomSection.add {type = "button", name = "close-zooming-screenshot-gui-button", caption = {"gui-caption.close-gui-button"}}
    local bottomSectionRightFlow = bottomSection.add {type = "flow", name = "zooming-screenshot-bottom-section-right-flow"}
    bottomSectionRightFlow.style.horizontally_stretchable = true
    bottomSectionRightFlow.style.horizontal_align = "right"
    bottomSectionRightFlow.add {type = "button", name = "zooming-screenshot-take-all-button", caption = {"gui-caption.take-all-screenshots-button"}}
end

function Gui.TakeAllScreenShots(player)
    Gui.CloseGui(player)
    Screenshot.TakeAllScreenShots(player)
end

return Gui
