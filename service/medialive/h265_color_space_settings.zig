const ColorSpacePassthroughSettings = @import("color_space_passthrough_settings.zig").ColorSpacePassthroughSettings;
const DolbyVision81Settings = @import("dolby_vision_81_settings.zig").DolbyVision81Settings;
const Hdr10Settings = @import("hdr_10_settings.zig").Hdr10Settings;
const Hlg2020Settings = @import("hlg_2020_settings.zig").Hlg2020Settings;
const Rec601Settings = @import("rec_601_settings.zig").Rec601Settings;
const Rec709Settings = @import("rec_709_settings.zig").Rec709Settings;

/// H265 Color Space Settings
pub const H265ColorSpaceSettings = struct {
    color_space_passthrough_settings: ?ColorSpacePassthroughSettings = null,

    dolby_vision_81_settings: ?DolbyVision81Settings = null,

    hdr_10_settings: ?Hdr10Settings = null,

    hlg_2020_settings: ?Hlg2020Settings = null,

    rec_601_settings: ?Rec601Settings = null,

    rec_709_settings: ?Rec709Settings = null,

    pub const json_field_names = .{
        .color_space_passthrough_settings = "ColorSpacePassthroughSettings",
        .dolby_vision_81_settings = "DolbyVision81Settings",
        .hdr_10_settings = "Hdr10Settings",
        .hlg_2020_settings = "Hlg2020Settings",
        .rec_601_settings = "Rec601Settings",
        .rec_709_settings = "Rec709Settings",
    };
};
