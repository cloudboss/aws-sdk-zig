/// Represents the shape of a reachable area. The geometry can be provided
/// either as coordinate pairs (`Polygon`) or in encoded format
/// (`PolylinePolygon`), matching the format specified in the request.
pub const IsolineShapeGeometry = struct {
    /// A series of coordinate rings defining the reachable area when Simple
    /// geometry format is requested. Each ring is a list of `[longitude, latitude]`
    /// coordinate pairs. The first ring defines the outer boundary; subsequent
    /// rings define holes representing unreachable areas.
    ///
    /// Polygon and PolylinePolygon are mutually exclusive properties.
    polygon: ?[]const []const []const f64 = null,

    /// An encoded representation of the reachable area when FlexiblePolyline
    /// geometry format is requested. Provides a compact representation suitable for
    /// transmission and storage. The first string defines the outer boundary;
    /// subsequent strings define holes representing unreachable areas. For more
    /// information on polyline encoding, see
    /// [https://github.com/aws-geospatial/polyline](https://github.com/aws-geospatial/polyline).
    ///
    /// Polygon and PolylinePolygon are mutually exclusive properties.
    polyline_polygon: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .polygon = "Polygon",
        .polyline_polygon = "PolylinePolygon",
    };
};
