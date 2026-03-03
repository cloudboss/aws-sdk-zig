const ColorSpacePassthroughSettings = @import("color_space_passthrough_settings.zig").ColorSpacePassthroughSettings;
const Hdr10Settings = @import("hdr_10_settings.zig").Hdr10Settings;
const Rec601Settings = @import("rec_601_settings.zig").Rec601Settings;
const Rec709Settings = @import("rec_709_settings.zig").Rec709Settings;

/// Av1 Color Space Settings
pub const Av1ColorSpaceSettings = struct {
    color_space_passthrough_settings: ?ColorSpacePassthroughSettings = null,

    hdr_10_settings: ?Hdr10Settings = null,

    rec_601_settings: ?Rec601Settings = null,

    rec_709_settings: ?Rec709Settings = null,

    pub const json_field_names = .{
        .color_space_passthrough_settings = "ColorSpacePassthroughSettings",
        .hdr_10_settings = "Hdr10Settings",
        .rec_601_settings = "Rec601Settings",
        .rec_709_settings = "Rec709Settings",
    };
};
