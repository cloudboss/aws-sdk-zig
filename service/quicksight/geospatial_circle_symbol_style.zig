const GeospatialCircleRadius = @import("geospatial_circle_radius.zig").GeospatialCircleRadius;
const GeospatialColor = @import("geospatial_color.zig").GeospatialColor;
const GeospatialLineWidth = @import("geospatial_line_width.zig").GeospatialLineWidth;

/// The properties for a circle symbol style.
pub const GeospatialCircleSymbolStyle = struct {
    /// The radius of the circle.
    circle_radius: ?GeospatialCircleRadius,

    /// The color and opacity values for the fill color.
    fill_color: ?GeospatialColor,

    /// The color and opacity values for the stroke color.
    stroke_color: ?GeospatialColor,

    /// The width of the stroke (border).
    stroke_width: ?GeospatialLineWidth,

    pub const json_field_names = .{
        .circle_radius = "CircleRadius",
        .fill_color = "FillColor",
        .stroke_color = "StrokeColor",
        .stroke_width = "StrokeWidth",
    };
};
