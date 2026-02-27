const GeospatialNullSymbolStyle = @import("geospatial_null_symbol_style.zig").GeospatialNullSymbolStyle;

/// The properties for the visualization of null data.
pub const GeospatialNullDataSettings = struct {
    /// The symbol style for null data.
    symbol_style: GeospatialNullSymbolStyle,

    pub const json_field_names = .{
        .symbol_style = "SymbolStyle",
    };
};
