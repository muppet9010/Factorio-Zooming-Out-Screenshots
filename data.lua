local Constants = require("constants")


data:extend({
    {
        type = "shortcut",
        name = "zooming-screenshot",
        action = "lua",
        icon = {
            filename = Constants.AssetModName .. "/graphics/gui/camera-button.png",
            width = 36,
            height = 36
        },
        small_icon = {
            filename = Constants.AssetModName .. "/graphics/gui/camera-button.png",
            width = 36,
            height = 36
        },
        disabled_small_icon = {
            filename = Constants.AssetModName .. "/graphics/gui/camera-button-disabled.png",
            width = 36,
            height = 36
        }
    },
    {
        type = "sprite",
        name = "zooming-screenshit-mod-icon",
        filename = Constants.AssetModName .. "/graphics/gui/camera-button.png",
        width = 36,
        height = 36
    }
})



local defaultStyle = data.raw["gui-style"]["default"]

defaultStyle.zs_padded_horizontal_flow = {
    type = "horizontal_flow_style",
    left_padding = 4,
    top_padding = 4,
}

defaultStyle.zs_mod_button_sprite = {
    type = "button_style",
    width = 36,
    height = 36,
    scalable = true,
}

--same size as a button
defaultStyle.zs_button_sprite = {
    type = "button_style",
    width = 42,
    height = 42,
    scalable = true,
}

defaultStyle.zs_gui_frame = {
    type = "frame_style",
    left_padding = 4,
    top_padding = 4,
}

defaultStyle.zs_padded_table = {
    type = "table_style",
    top_padding = 5,
    bottom_padding = 5,
    left_padding = 5,
    right_padding = 5,
}

defaultStyle.zs_padded_table_cell = {
    type = "label_style",
    top_padding = 5,
    bottom_padding = 5,
    left_padding = 5,
    right_padding = 5,
}

defaultStyle.zs_small_button = {
    type = "button_style",
    padding = 2,
    font = "default",
}
