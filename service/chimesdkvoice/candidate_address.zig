/// A suggested address.
pub const CandidateAddress = struct {
    /// The city of the candidate address.
    city: ?[]const u8 = null,

    /// The country of the candidate address.
    country: ?[]const u8 = null,

    /// The postal code of the candidate address.
    postal_code: ?[]const u8 = null,

    /// The zip + 4 or postal code +4 of the candidate address.
    postal_code_plus_4: ?[]const u8 = null,

    /// The state of the candidate address.
    state: ?[]const u8 = null,

    /// The street information of the candidate address.
    street_info: ?[]const u8 = null,

    /// The numeric portion of the candidate address.
    street_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "city",
        .country = "country",
        .postal_code = "postalCode",
        .postal_code_plus_4 = "postalCodePlus4",
        .state = "state",
        .street_info = "streetInfo",
        .street_number = "streetNumber",
    };
};
