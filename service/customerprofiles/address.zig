/// A generic address associated with the customer that is not mailing,
/// shipping, or
/// billing.
pub const Address = struct {
    /// The first line of a customer address.
    address_1: ?[]const u8,

    /// The second line of a customer address.
    address_2: ?[]const u8,

    /// The third line of a customer address.
    address_3: ?[]const u8,

    /// The fourth line of a customer address.
    address_4: ?[]const u8,

    /// The city in which a customer lives.
    city: ?[]const u8,

    /// The country in which a customer lives.
    country: ?[]const u8,

    /// The county in which a customer lives.
    county: ?[]const u8,

    /// The postal code of a customer address.
    postal_code: ?[]const u8,

    /// The province in which a customer lives.
    province: ?[]const u8,

    /// The state in which a customer lives.
    state: ?[]const u8,

    pub const json_field_names = .{
        .address_1 = "Address1",
        .address_2 = "Address2",
        .address_3 = "Address3",
        .address_4 = "Address4",
        .city = "City",
        .country = "Country",
        .county = "County",
        .postal_code = "PostalCode",
        .province = "Province",
        .state = "State",
    };
};
