/// Represents a latitude and longitude pair, expressed in geographic coordinate
/// system degrees (for
/// example, 47.6204, -122.3491).
///
/// Elevation is currently not supported.
pub const Location = struct {
    /// The latitude.
    latitude: f64,

    /// The longitude.
    longitude: f64,

    pub const json_field_names = .{
        .latitude = "latitude",
        .longitude = "longitude",
    };
};
