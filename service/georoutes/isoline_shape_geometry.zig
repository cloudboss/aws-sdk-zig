/// Geometry of the connection between different Isoline components.
pub const IsolineShapeGeometry = struct {
    /// A list of Isoline Polygons, for each isoline polygon, it contains polygons
    /// of the first linear ring (the outer ring) and from 2nd item to the last item
    /// (the inner rings).
    polygon: ?[]const []const []const f64,

    /// A list of Isoline PolylinePolygon, for each isoline PolylinePolygon, it
    /// contains PolylinePolygon of the first linear ring (the outer ring) and from
    /// 2nd item to the last item (the inner rings). For more information on
    /// polyline encoding, see
    /// [https://github.com/heremaps/flexiblepolyline/blob/master/README.md](https://github.com/heremaps/flexiblepolyline/blob/master/README.md).
    polyline_polygon: ?[]const []const u8,

    pub const json_field_names = .{
        .polygon = "Polygon",
        .polyline_polygon = "PolylinePolygon",
    };
};
