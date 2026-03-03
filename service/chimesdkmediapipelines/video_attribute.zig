const BorderColor = @import("border_color.zig").BorderColor;
const HighlightColor = @import("highlight_color.zig").HighlightColor;

/// Defines the settings for a video tile.
pub const VideoAttribute = struct {
    /// Defines the border color of all video tiles.
    border_color: ?BorderColor = null,

    /// Defines the border thickness for all video tiles.
    border_thickness: ?i32 = null,

    /// Sets the corner radius of all video tiles.
    corner_radius: ?i32 = null,

    /// Defines the highlight color for the active video tile.
    highlight_color: ?HighlightColor = null,

    pub const json_field_names = .{
        .border_color = "BorderColor",
        .border_thickness = "BorderThickness",
        .corner_radius = "CornerRadius",
        .highlight_color = "HighlightColor",
    };
};
