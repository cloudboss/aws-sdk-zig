/// Information about an address.
pub const Address = struct {
    /// The first line of the address.
    address_line_1: []const u8,

    /// The second line of the address.
    address_line_2: ?[]const u8,

    /// The third line of the address.
    address_line_3: ?[]const u8,

    /// The city for the address.
    city: []const u8,

    /// The name of the contact.
    contact_name: []const u8,

    /// The phone number of the contact.
    contact_phone_number: []const u8,

    /// The ISO-3166 two-letter country code for the address.
    country_code: []const u8,

    /// The district or county for the address.
    district_or_county: ?[]const u8,

    /// The municipality for the address.
    municipality: ?[]const u8,

    /// The postal code for the address.
    postal_code: []const u8,

    /// The state for the address.
    state_or_region: []const u8,

    pub const json_field_names = .{
        .address_line_1 = "AddressLine1",
        .address_line_2 = "AddressLine2",
        .address_line_3 = "AddressLine3",
        .city = "City",
        .contact_name = "ContactName",
        .contact_phone_number = "ContactPhoneNumber",
        .country_code = "CountryCode",
        .district_or_county = "DistrictOrCounty",
        .municipality = "Municipality",
        .postal_code = "PostalCode",
        .state_or_region = "StateOrRegion",
    };
};
