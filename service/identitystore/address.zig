/// The address associated with the specified user.
pub const Address = struct {
    /// The country of the address.
    country: ?[]const u8,

    /// A string containing a formatted version of the address for display.
    formatted: ?[]const u8,

    /// A string of the address locality.
    locality: ?[]const u8,

    /// The postal code of the address.
    postal_code: ?[]const u8,

    /// A Boolean value representing whether this is the primary address for the
    /// associated resource.
    primary: bool = false,

    /// The region of the address.
    region: ?[]const u8,

    /// The street of the address.
    street_address: ?[]const u8,

    /// A string representing the type of address. For example, "Home."
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .country = "Country",
        .formatted = "Formatted",
        .locality = "Locality",
        .postal_code = "PostalCode",
        .primary = "Primary",
        .region = "Region",
        .street_address = "StreetAddress",
        .@"type" = "Type",
    };
};
