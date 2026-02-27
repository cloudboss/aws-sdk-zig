const Corridor = @import("corridor.zig").Corridor;
const PolylineCorridor = @import("polyline_corridor.zig").PolylineCorridor;

/// The avoidance geometry, to be included while calculating an isoline.
pub const IsolineAvoidanceAreaGeometry = struct {
    /// Geometry defined as a bounding box. The first pair represents the X and Y
    /// coordinates (longitude and latitude,) of the southwest corner of the
    /// bounding box; the second pair represents the X and Y coordinates (longitude
    /// and latitude) of the northeast corner.
    bounding_box: ?[]const f64,

    /// Geometry defined as a corridor - a LineString with a radius that defines the
    /// width of the corridor.
    corridor: ?Corridor,

    /// A list of Polygon will be excluded for calculating isolines, the list can
    /// only contain 1 polygon.
    polygon: ?[]const []const []const f64,

    /// Geometry defined as an encoded corridor – a polyline with a radius that
    /// defines the width of the corridor. For more information on polyline
    /// encoding, see
    /// [https://github.com/heremaps/flexiblepolyline/blob/master/README.md](https://github.com/heremaps/flexiblepolyline/blob/master/README.md).
    polyline_corridor: ?PolylineCorridor,

    /// A list of PolylinePolygon's that are excluded for calculating isolines, the
    /// list can only contain 1 polygon. For more information on polyline encoding,
    /// see
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
