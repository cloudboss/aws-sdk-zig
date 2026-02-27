/// Specifies the GPS coordinates of a location.
pub const GPSCoordinates = struct {
    /// The latitude coordinate of the location.
    latitude: f64,

    /// The longitude coordinate of the location.
    longitude: f64,

    pub const json_field_names = .{
        .latitude = "Latitude",
        .longitude = "Longitude",
    };
};
