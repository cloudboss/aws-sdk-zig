const GeospatialLineStyle = @import("geospatial_line_style.zig").GeospatialLineStyle;

/// The geospatial Line layer.
pub const GeospatialLineLayer = struct {
    /// The visualization style for a line layer.
    style: GeospatialLineStyle,

    pub const json_field_names = .{
        .style = "Style",
    };
};
