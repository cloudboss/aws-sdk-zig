const GeospatialPolygonStyle = @import("geospatial_polygon_style.zig").GeospatialPolygonStyle;

/// The geospatial polygon layer.
pub const GeospatialPolygonLayer = struct {
    /// The visualization style for a polygon layer.
    style: GeospatialPolygonStyle,

    pub const json_field_names = .{
        .style = "Style",
    };
};
