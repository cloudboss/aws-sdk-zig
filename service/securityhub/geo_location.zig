/// Provides the latitude and longitude coordinates of a location.
pub const GeoLocation = struct {
    /// The latitude of the location.
    lat: ?f64 = null,

    /// The longitude of the location.
    lon: ?f64 = null,

    pub const json_field_names = .{
        .lat = "Lat",
        .lon = "Lon",
    };
};
