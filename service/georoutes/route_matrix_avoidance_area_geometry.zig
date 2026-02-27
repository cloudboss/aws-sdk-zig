/// Geometry of the area to be avoided.
pub const RouteMatrixAvoidanceAreaGeometry = struct {
    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    bounding_box: ?[]const f64,

    /// Geometry defined as a polygon with only one linear ring.
    polygon: ?[]const []const []const f64,

    /// A list of Isoline PolylinePolygon, for each isoline PolylinePolygon, it
    /// contains PolylinePolygon of the first linear ring (the outer ring) and from
    /// second item to the last item (the inner rings). For more information on
    /// polyline encoding, see
    /// [https://github.com/heremaps/flexiblepolyline/blob/master/README.md](https://github.com/heremaps/flexiblepolyline/blob/master/README.md).
    polyline_polygon: ?[]const []const u8,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .polygon = "Polygon",
        .polyline_polygon = "PolylinePolygon",
    };
};
