/// The address information for a lead customer, including city, state or
/// region, postal code, and country code.
pub const LeadAddress = struct {
    /// The city of the lead customer's address.
    city: ?[]const u8 = null,

    /// The country code of the lead customer's address.
    country_code: ?[]const u8 = null,

    /// The postal code of the lead customer's address.
    postal_code: ?[]const u8 = null,

    /// The state or region of the lead customer's address.
    state_or_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .country_code = "CountryCode",
        .postal_code = "PostalCode",
        .state_or_region = "StateOrRegion",
    };
};
