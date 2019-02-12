local Gui = require("gui")


local function MakeGlobals()
    if global.MOD == nil then global.MOD = {} end
    if global.MOD.guiScreenshotSettings == nil then global.MOD.guiScreenshotSettings = {} end
end


local function PlayerJoinedEvent(eventData)
    local player = game.players[eventData.player_index]
    Gui.GenerateDefaultSettings(player)
    Gui.RecreateModButton(player)
end


local function OnInit()
    MakeGlobals()
    Gui.RecreateModButtonForAll()
end


local function OnConfigurationChanged()
    MakeGlobals()
    Gui.GenerateDefaultSettingsForAll()
    Gui.RecreateModButtonForAll()
end


script.on_init(OnInit)
script.on_configuration_changed(OnConfigurationChanged)
script.on_event(defines.events.on_player_joined_game, PlayerJoinedEvent)
script.on_event(defines.events.on_gui_click, Gui.GuiClickedEvent)
script.on_event(defines.events.on_gui_text_changed, Gui.GuiTextChangedEvent)
script.on_event(defines.events.on_gui_selection_state_changed, Gui.GuiSelectionStateChangedEvent)
