/// The details of the address associated with the receiver.
pub const ReceiverAddress = struct {
    /// The first line of the address.
    address_line_1: ?[]const u8 = null,

    /// The second line of the address, if applicable.
    address_line_2: ?[]const u8 = null,

    /// The third line of the address, if applicable.
    address_line_3: ?[]const u8 = null,

    /// The city that the address is in.
    city: ?[]const u8 = null,

    /// A unique company name.
    company_name: ?[]const u8 = null,

    /// The country code for the country the address is in.
    country_code: ?[]const u8 = null,

    /// The district or country the address is located in.
    district_or_county: ?[]const u8 = null,

    /// The postal code associated with the address.
    postal_code: ?[]const u8 = null,

    /// The state, region, or province the address is located.
    state_or_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_line_1 = "AddressLine1",
        .address_line_2 = "AddressLine2",
        .address_line_3 = "AddressLine3",
        .city = "City",
        .company_name = "CompanyName",
        .country_code = "CountryCode",
        .district_or_county = "DistrictOrCounty",
        .postal_code = "PostalCode",
        .state_or_region = "StateOrRegion",
    };
};
