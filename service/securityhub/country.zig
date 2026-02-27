/// Information about a country.
pub const Country = struct {
    /// The 2-letter ISO 3166 country code for the country.
    country_code: ?[]const u8,

    /// The name of the country.
    country_name: ?[]const u8,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .country_name = "CountryName",
    };
};
