/// The symbol style for null data.
pub const GeospatialNullSymbolStyle = struct {
    /// The color and opacity values for the fill color.
    fill_color: ?[]const u8 = null,

    /// The color and opacity values for the stroke color.
    stroke_color: ?[]const u8 = null,

    /// The width of the border stroke.
    stroke_width: ?f64 = null,

    pub const json_field_names = .{
        .fill_color = "FillColor",
        .stroke_color = "StrokeColor",
        .stroke_width = "StrokeWidth",
    };
};
