/// The preference coordinate for the geocode preference.
pub const Coordinate = struct {
    /// The latitude coordinate value for the geocode preference.
    latitude: f64,

    /// The longitude coordinate value for the geocode preference.
    longitude: f64,

    pub const json_field_names = .{
        .latitude = "Latitude",
        .longitude = "Longitude",
    };
};
