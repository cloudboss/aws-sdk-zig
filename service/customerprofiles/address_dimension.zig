const ProfileDimension = @import("profile_dimension.zig").ProfileDimension;

/// Object that segments on Customer Profile's address object.
pub const AddressDimension = struct {
    /// The city belonging to the address.
    city: ?ProfileDimension,

    /// The country belonging to the address.
    country: ?ProfileDimension,

    /// The county belonging to the address.
    county: ?ProfileDimension,

    /// The postal code belonging to the address.
    postal_code: ?ProfileDimension,

    /// The province belonging to the address.
    province: ?ProfileDimension,

    /// The state belonging to the address.
    state: ?ProfileDimension,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .county = "County",
        .postal_code = "PostalCode",
        .province = "Province",
        .state = "State",
    };
};
