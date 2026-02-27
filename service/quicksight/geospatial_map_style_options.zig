const BaseMapStyleType = @import("base_map_style_type.zig").BaseMapStyleType;

/// The map style options of the geospatial map.
pub const GeospatialMapStyleOptions = struct {
    /// The base map style of the geospatial map.
    base_map_style: ?BaseMapStyleType,

    pub const json_field_names = .{
        .base_map_style = "BaseMapStyle",
    };
};
