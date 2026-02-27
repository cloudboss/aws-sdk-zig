/// The details of the address associated with the TRN information.
pub const Address = struct {
    /// The first line of the address.
    address_line_1: []const u8,

    /// The second line of the address, if applicable.
    address_line_2: ?[]const u8,

    /// The third line of the address, if applicable. Currently, the Tax Settings
    /// API accepts the
    /// `addressLine3` parameter only for Saudi Arabia. When you specify a TRN in
    /// Saudi
    /// Arabia, you must enter the `addressLine3` and specify the building number
    /// for the
    /// address. For example, you might enter `1234`.
    address_line_3: ?[]const u8,

    /// The city that the address is in.
    city: []const u8,

    /// The country code for the country that the address is in.
    country_code: []const u8,

    /// The district or county the address is located.
    ///
    /// For addresses in Brazil, this parameter uses the name of the neighborhood.
    /// When you set
    /// a TRN in Brazil, use `districtOrCounty` for the neighborhood name.
    district_or_county: ?[]const u8,

    /// The postal code associated with the address.
    postal_code: []const u8,

    /// The state, region, or province that the address is located. This field is
    /// only required for Canada, India, United Arab Emirates, Romania, and Brazil
    /// (CPF). It is optional for all other countries.
    ///
    /// If this is required for tax settings, use the same name as shown on the
    /// **Tax Settings** page.
    state_or_region: ?[]const u8,

    pub const json_field_names = .{
        .address_line_1 = "addressLine1",
        .address_line_2 = "addressLine2",
        .address_line_3 = "addressLine3",
        .city = "city",
        .country_code = "countryCode",
        .district_or_county = "districtOrCounty",
        .postal_code = "postalCode",
        .state_or_region = "stateOrRegion",
    };
};
