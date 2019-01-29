local Gui = require("gui")


local function GenerateDefaultSettings(player)
    local player_index = player.index
    if global.MOD.guiScreenshotSettings[player_index] == nil then global.MOD.guiScreenshotSettings[player_index] = {} end
    local guiScreenshotSettings = global.MOD.guiScreenshotSettings[player_index]
    if guiScreenshotSettings["zooming-screenshot-start-zoom"] == nil then guiScreenshotSettings["zooming-screenshot-start-zoom"] = 20 end
    if guiScreenshotSettings["zooming-screenshot-end-zoom"] == nil then guiScreenshotSettings["zooming-screenshot-end-zoom"] = 0.125 end
    if guiScreenshotSettings["zooming-screenshot-count"] == nil then guiScreenshotSettings["zooming-screenshot-count"] = 100 end
    if guiScreenshotSettings["zooming-screenshot-resolution-x"] == nil then guiScreenshotSettings["zooming-screenshot-resolution-x"] = 1024 end
    if guiScreenshotSettings["zooming-screenshot-resolution-y"] == nil then guiScreenshotSettings["zooming-screenshot-resolution-y"] = 765 end
    if guiScreenshotSettings["zooming-screenshot-show-gui"] == nil then guiScreenshotSettings["zooming-screenshot-show-gui"] = 2 end
    if guiScreenshotSettings["zooming-screenshot-show-entity-info"] == nil then guiScreenshotSettings["zooming-screenshot-show-entity-info"] = 2 end
    if guiScreenshotSettings["zooming-screenshot-anti-alias"] == nil then guiScreenshotSettings["zooming-screenshot-anti-alias"] = 2 end
end


local function MakeGlobals()
    if global.MOD == nil then global.MOD = {} end
    if global.MOD.guiScreenshotSettings == nil then global.MOD.guiScreenshotSettings = {} end
end


local function PlayerJoinedEvent(eventData)
    local player = game.players[eventData.player_index]
    GenerateDefaultSettings(player)
    Gui.RecreateModButton(player)
end


script.on_init(function()
    MakeGlobals()
    Gui.RecreateModButtonForAll()
end)
script.on_configuration_changed(function()
    MakeGlobals()
    Gui.RecreateModButtonForAll()
end)
script.on_event(defines.events.on_player_joined_game, PlayerJoinedEvent)
script.on_event(defines.events.on_gui_click, Gui.GuiClickedEvent)
script.on_event(defines.events.on_gui_text_changed, Gui.GuiTextChangedEvent)
script.on_event(defines.events.on_gui_selection_state_changed, Gui.GuiSelectionStateChangedEvent)
