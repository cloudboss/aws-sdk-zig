const GeospatialPointStyle = @import("geospatial_point_style.zig").GeospatialPointStyle;

/// The geospatial Point layer.
pub const GeospatialPointLayer = struct {
    /// The visualization style for a point layer.
    style: GeospatialPointStyle,

    pub const json_field_names = .{
        .style = "Style",
    };
};
