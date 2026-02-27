const HtmlMotionGraphicsSettings = @import("html_motion_graphics_settings.zig").HtmlMotionGraphicsSettings;

/// Motion Graphics Settings
pub const MotionGraphicsSettings = struct {
    html_motion_graphics_settings: ?HtmlMotionGraphicsSettings,

    pub const json_field_names = .{
        .html_motion_graphics_settings = "HtmlMotionGraphicsSettings",
    };
};
