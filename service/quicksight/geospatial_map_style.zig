const BaseMapStyleType = @import("base_map_style_type.zig").BaseMapStyleType;
const Visibility = @import("visibility.zig").Visibility;

/// The map style properties for a map.
pub const GeospatialMapStyle = struct {
    /// The background color and opacity values for a map.
    background_color: ?[]const u8 = null,

    /// The selected base map style.
    base_map_style: ?BaseMapStyleType = null,

    /// The state of visibility for the base map.
    base_map_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .base_map_style = "BaseMapStyle",
        .base_map_visibility = "BaseMapVisibility",
    };
};
