const Hdr10Settings = @import("hdr_10_settings.zig").Hdr10Settings;

/// Video Selector Color Space Settings
pub const VideoSelectorColorSpaceSettings = struct {
    hdr_10_settings: ?Hdr10Settings = null,

    pub const json_field_names = .{
        .hdr_10_settings = "Hdr10Settings",
    };
};
