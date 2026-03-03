/// Specifies geographic information about an endpoint.
pub const EndpointLocation = struct {
    /// The name of the city where the endpoint is located.
    city: ?[]const u8 = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region where the endpoint is located. For example, US for the United States.
    country: ?[]const u8 = null,

    /// The latitude coordinate of the endpoint location, rounded to one decimal
    /// place.
    latitude: ?f64 = null,

    /// The longitude coordinate of the endpoint location, rounded to one decimal
    /// place.
    longitude: ?f64 = null,

    /// The postal or ZIP code for the area where the endpoint is located.
    postal_code: ?[]const u8 = null,

    /// The name of the region where the endpoint is located. For locations in the
    /// United States, this value is the name of a state.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .latitude = "Latitude",
        .longitude = "Longitude",
        .postal_code = "PostalCode",
        .region = "Region",
    };
};
