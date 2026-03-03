/// Provides geographic coordinates that indicate where a specified IP address
/// originated from.
pub const IpGeoLocation = struct {
    /// The latitude coordinate of the location, rounded to four decimal places.
    lat: ?f64 = null,

    /// The longitude coordinate of the location, rounded to four decimal places.
    lon: ?f64 = null,

    pub const json_field_names = .{
        .lat = "lat",
        .lon = "lon",
    };
};
