/// The structure representing a Geometry in
/// terms of Type and Coordinates as per GeoJson spec.
pub const Geometry = struct {
    /// The coordinates of the GeoJson Geometry.
    coordinates: []const []const []const f64,

    /// GeoJson Geometry types like Polygon and MultiPolygon.
    type: []const u8,

    pub const json_field_names = .{
        .coordinates = "Coordinates",
        .type = "Type",
    };
};
