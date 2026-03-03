const GeospatialColor = @import("geospatial_color.zig").GeospatialColor;
const GeospatialLineWidth = @import("geospatial_line_width.zig").GeospatialLineWidth;

/// The polygon symbol style for a polygon layer.
pub const GeospatialPolygonSymbolStyle = struct {
    /// The color and opacity values for the fill color.
    fill_color: ?GeospatialColor = null,

    /// The color and opacity values for the stroke color.
    stroke_color: ?GeospatialColor = null,

    /// The width of the border stroke.
    stroke_width: ?GeospatialLineWidth = null,

    pub const json_field_names = .{
        .fill_color = "FillColor",
        .stroke_color = "StrokeColor",
        .stroke_width = "StrokeWidth",
    };
};
