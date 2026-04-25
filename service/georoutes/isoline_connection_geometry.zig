/// Represents the geometry of connections between non-contiguous parts of an
/// isoline. These connections can be provided in either coordinate pairs
/// (LineString) or encoded (Polyline) format, matching the format specified in
/// the request.
pub const IsolineConnectionGeometry = struct {
    /// A series of `[longitude, latitude]` coordinate pairs defining the connection
    /// path when `Simple` geometry format is requested. These coordinates can be
    /// directly used as the coordinates array in a GeoJSON LineString without
    /// transformation.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    line_string: ?[]const []const f64 = null,

    /// An encoded representation of the connection path when `FlexiblePolyline`
    /// geometry format is requested. This provides a more compact representation
    /// suitable for transmission and storage. To convert to GeoJSON, first decode
    /// to obtain coordinate pairs, then use those coordinates as the coordinates
    /// array in a GeoJSON LineString.
    ///
    /// LineString and Polyline are mutually exclusive properties.
    polyline: ?[]const u8 = null,

    pub const json_field_names = .{
        .line_string = "LineString",
        .polyline = "Polyline",
    };
};
