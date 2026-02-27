const Corridor = @import("corridor.zig").Corridor;
const PolylineCorridor = @import("polyline_corridor.zig").PolylineCorridor;

/// Geometry of the area to be avoided.
pub const RouteAvoidanceAreaGeometry = struct {
    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    bounding_box: ?[]const f64,

    /// Geometry defined as a corridor - a LineString with a radius that defines the
    /// width of the corridor.
    corridor: ?Corridor,

    /// Geometry defined as a polygon with only one linear ring.
    polygon: ?[]const []const []const f64,

    /// Geometry defined as an encoded corridor - an encoded polyline with a radius
    /// that defines the width of the corridor.
    polyline_corridor: ?PolylineCorridor,

    /// A list of Isoline PolylinePolygon, for each isoline PolylinePolygon, it
    /// contains PolylinePolygon of the first linear ring (the outer ring) and from
    /// 2nd item to the last item (the inner rings). For more information on
    /// polyline encoding, see
    /// [https://github.com/heremaps/flexiblepolyline/blob/master/README.md](https://github.com/heremaps/flexiblepolyline/blob/master/README.md).
    polyline_polygon: ?[]const []const u8,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .corridor = "Corridor",
        .polygon = "Polygon",
        .polyline_corridor = "PolylineCorridor",
        .polyline_polygon = "PolylinePolygon",
    };
};
