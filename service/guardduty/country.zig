/// Contains information about the country where the remote IP address is
/// located.
pub const Country = struct {
    /// The country code of the remote IP address.
    country_code: ?[]const u8 = null,

    /// The country name of the remote IP address.
    country_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .country_name = "CountryName",
    };
};
