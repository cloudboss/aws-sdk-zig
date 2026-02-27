/// The preference hierarchy for the geocode preference.
pub const GeocoderHierarchy = struct {
    /// The city value for the preference hierarchy.
    city: ?[]const u8,

    /// The country value for the preference hierarchy.
    country: ?[]const u8,

    /// The county/district value for the preference hierarchy.
    county: ?[]const u8,

    /// The postcode value for the preference hierarchy.
    post_code: ?[]const u8,

    /// The state/region value for the preference hierarchy.
    state: ?[]const u8,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .county = "County",
        .post_code = "PostCode",
        .state = "State",
    };
};
