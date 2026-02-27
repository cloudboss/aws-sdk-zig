/// Contains information about network endpoint location.
pub const NetworkGeoLocation = struct {
    /// The name of the city.
    city: []const u8,

    /// The name of the country.
    country: []const u8,

    /// The latitude information of the endpoint location.
    latitude: f64,

    /// The longitude information of the endpoint location.
    longitude: f64,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .latitude = "Latitude",
        .longitude = "Longitude",
    };
};
