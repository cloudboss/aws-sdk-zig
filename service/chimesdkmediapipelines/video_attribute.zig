const BorderColor = @import("border_color.zig").BorderColor;
const HighlightColor = @import("highlight_color.zig").HighlightColor;

/// Defines the settings for a video tile.
pub const VideoAttribute = struct {
    /// Defines the border color of all video tiles.
    border_color: ?BorderColor,

    /// Defines the border thickness for all video tiles.
    border_thickness: ?i32,

    /// Sets the corner radius of all video tiles.
    corner_radius: ?i32,

    /// Defines the highlight color for the active video tile.
    highlight_color: ?HighlightColor,

    pub const json_field_names = .{
        .border_color = "BorderColor",
        .border_thickness = "BorderThickness",
        .corner_radius = "CornerRadius",
        .highlight_color = "HighlightColor",
    };
};
