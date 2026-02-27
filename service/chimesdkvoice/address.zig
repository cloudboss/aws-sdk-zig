/// A validated address.
pub const Address = struct {
    /// The city of an address.
    city: ?[]const u8,

    /// The country of an address.
    country: ?[]const u8,

    /// The postal code of an address.
    postal_code: ?[]const u8,

    /// The zip + 4 or postal code + 4 of an address.
    postal_code_plus_4: ?[]const u8,

    /// An address suffix location, such as the `S. Unit A` in
    /// `Central Park S. Unit A`.
    post_directional: ?[]const u8,

    /// An address prefix location, such as the `N` in `N. Third St.`
    pre_directional: ?[]const u8,

    /// The state of an address.
    state: ?[]const u8,

    /// The address street, such as `8th Avenue`.
    street_name: ?[]const u8,

    /// The numeric portion of an address.
    street_number: ?[]const u8,

    /// The address suffix, such as the `N` in `8th Avenue N`.
    street_suffix: ?[]const u8,

    pub const json_field_names = .{
        .city = "city",
        .country = "country",
        .postal_code = "postalCode",
        .postal_code_plus_4 = "postalCodePlus4",
        .post_directional = "postDirectional",
        .pre_directional = "preDirectional",
        .state = "state",
        .street_name = "streetName",
        .street_number = "streetNumber",
        .street_suffix = "streetSuffix",
    };
};
