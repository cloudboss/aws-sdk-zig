const GeospatialLineSymbolStyle = @import("geospatial_line_symbol_style.zig").GeospatialLineSymbolStyle;

/// The visualization style for a line layer.
pub const GeospatialLineStyle = struct {
    /// The symbol style for a line style.
    line_symbol_style: ?GeospatialLineSymbolStyle = null,

    pub const json_field_names = .{
        .line_symbol_style = "LineSymbolStyle",
    };
};
