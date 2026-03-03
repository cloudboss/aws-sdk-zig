const GeospatialPolygonSymbolStyle = @import("geospatial_polygon_symbol_style.zig").GeospatialPolygonSymbolStyle;

/// The polygon style for a polygon layer.
pub const GeospatialPolygonStyle = struct {
    /// The polygon symbol style for a polygon layer.
    polygon_symbol_style: ?GeospatialPolygonSymbolStyle = null,

    pub const json_field_names = .{
        .polygon_symbol_style = "PolygonSymbolStyle",
    };
};
