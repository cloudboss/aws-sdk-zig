const ColorSpacePassthroughSettings = @import("color_space_passthrough_settings.zig").ColorSpacePassthroughSettings;
const Rec601Settings = @import("rec_601_settings.zig").Rec601Settings;
const Rec709Settings = @import("rec_709_settings.zig").Rec709Settings;

/// H264 Color Space Settings
pub const H264ColorSpaceSettings = struct {
    color_space_passthrough_settings: ?ColorSpacePassthroughSettings,

    rec_601_settings: ?Rec601Settings,

    rec_709_settings: ?Rec709Settings,

    pub const json_field_names = .{
        .color_space_passthrough_settings = "ColorSpacePassthroughSettings",
        .rec_601_settings = "Rec601Settings",
        .rec_709_settings = "Rec709Settings",
    };
};
