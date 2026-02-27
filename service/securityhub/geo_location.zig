/// Provides the latitude and longitude coordinates of a location.
pub const GeoLocation = struct {
    /// The latitude of the location.
    lat: ?f64,

    /// The longitude of the location.
    lon: ?f64,

    pub const json_field_names = .{
        .lat = "Lat",
        .lon = "Lon",
    };
};
