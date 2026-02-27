const Visibility = @import("visibility.zig").Visibility;

/// Border settings configuration for visual elements, including visibility,
/// width, and color properties.
pub const BorderSettings = struct {
    /// Color of the border.
    border_color: ?[]const u8,

    /// Visibility setting for the border.
    border_visibility: ?Visibility,

    /// Width of the border. Valid range is from 1px to 8px.
    border_width: ?[]const u8,

    pub const json_field_names = .{
        .border_color = "BorderColor",
        .border_visibility = "BorderVisibility",
        .border_width = "BorderWidth",
    };
};
