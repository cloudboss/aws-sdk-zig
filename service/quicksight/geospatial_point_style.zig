const GeospatialCircleSymbolStyle = @import("geospatial_circle_symbol_style.zig").GeospatialCircleSymbolStyle;

/// The point style for a point layer.
pub const GeospatialPointStyle = struct {
    /// The circle symbol style for a point layer.
    circle_symbol_style: ?GeospatialCircleSymbolStyle = null,

    pub const json_field_names = .{
        .circle_symbol_style = "CircleSymbolStyle",
    };
};
