/// The structure representing Polygon Geometry based on the [GeoJson
/// spec](https://www.rfc-editor.org/rfc/rfc7946#section-3.1.6).
pub const MultiPolygonGeometryInput = struct {
    /// The coordinates of the multipolygon geometry.
    coordinates: []const []const []const []const f64,

    pub const json_field_names = .{
        .coordinates = "Coordinates",
    };
};
