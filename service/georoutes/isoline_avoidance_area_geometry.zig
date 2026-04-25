const Corridor = @import("corridor.zig").Corridor;
const PolylineCorridor = @import("polyline_corridor.zig").PolylineCorridor;

/// Defines an area to avoid during calculations using one of several supported
/// geometry types. The service will prefer routes that avoid these areas when
/// possible.
pub const IsolineAvoidanceAreaGeometry = struct {
    /// A rectangular area defined by its southwest and northeast corners: `[min
    /// longitude, min latitude, max longitude, max latitude]`.
    bounding_box: ?[]const f64 = null,

    /// A buffer zone around a line, defined by a series of coordinates and a radius
    /// in meters.
    corridor: ?Corridor = null,

    /// A polygon defined by a list of coordinate rings. The first ring defines the
    /// outer boundary; subsequent rings will be ignored.
    polygon: ?[]const []const []const f64 = null,

    /// A buffer zone around a compressed polyline, defined by an encoded polyline
    /// string and a radius in meters. For more information on polyline encoding,
    /// see
    /// [https://github.com/aws-geospatial/polyline](https://github.com/aws-geospatial/polyline).
    polyline_corridor: ?PolylineCorridor = null,

    /// A polygon defined by encoded polyline strings. The first string defines the
    /// outer boundary; subsequent strings will be ignored. For more information on
    /// polyline encoding, see
    /// [https://github.com/aws-geospatial/polyline](https://github.com/aws-geospatial/polyline).
    polyline_polygon: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .corridor = "Corridor",
        .polygon = "Polygon",
        .polyline_corridor = "PolylineCorridor",
        .polyline_polygon = "PolylinePolygon",
    };
};
