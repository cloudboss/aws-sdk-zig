/// The symbol style for null data.
pub const GeospatialNullSymbolStyle = struct {
    /// The color and opacity values for the fill color.
    fill_color: ?[]const u8,

    /// The color and opacity values for the stroke color.
    stroke_color: ?[]const u8,

    /// The width of the border stroke.
    stroke_width: ?f64,

    pub const json_field_names = .{
        .fill_color = "FillColor",
        .stroke_color = "StrokeColor",
        .stroke_width = "StrokeWidth",
    };
};
