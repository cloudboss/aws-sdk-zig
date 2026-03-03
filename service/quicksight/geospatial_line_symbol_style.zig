const GeospatialColor = @import("geospatial_color.zig").GeospatialColor;
const GeospatialLineWidth = @import("geospatial_line_width.zig").GeospatialLineWidth;

/// The symbol style for a line layer.
pub const GeospatialLineSymbolStyle = struct {
    /// The color and opacity values for the fill color.
    fill_color: ?GeospatialColor = null,

    /// The width value for a line.
    line_width: ?GeospatialLineWidth = null,

    pub const json_field_names = .{
        .fill_color = "FillColor",
        .line_width = "LineWidth",
    };
};
