const AddressType = @import("address_type.zig").AddressType;

/// The address that you want the Snow device(s) associated with a specific job
/// to be
/// shipped to. Addresses are validated at the time of creation. The address you
/// provide must be
/// located within the serviceable area of your region. Although no individual
/// elements of the
/// `Address` are required, if the address is invalid or unsupported, then an
/// exception is thrown.
pub const Address = struct {
    /// The unique ID for an address.
    address_id: ?[]const u8,

    /// The city in an address that a Snow device is to be delivered to.
    city: ?[]const u8,

    /// The name of the company to receive a Snow device at an address.
    company: ?[]const u8,

    /// The country in an address that a Snow device is to be delivered to.
    country: ?[]const u8,

    /// If the address you are creating is a primary address, then set this option
    /// to
    /// true. This field is not supported in most regions.
    is_restricted: bool = false,

    /// This field is no longer used and the value is ignored.
    landmark: ?[]const u8,

    /// The name of a person to receive a Snow device at an address.
    name: ?[]const u8,

    /// The phone number associated with an address that a Snow device is to be
    /// delivered
    /// to.
    phone_number: ?[]const u8,

    /// The postal code in an address that a Snow device is to be delivered to.
    postal_code: ?[]const u8,

    /// This field is no longer used and the value is ignored.
    prefecture_or_district: ?[]const u8,

    /// The state or province in an address that a Snow device is to be delivered
    /// to.
    state_or_province: ?[]const u8,

    /// The first line in a street address that a Snow device is to be delivered
    /// to.
    street_1: ?[]const u8,

    /// The second line in a street address that a Snow device is to be delivered
    /// to.
    street_2: ?[]const u8,

    /// The third line in a street address that a Snow device is to be delivered
    /// to.
    street_3: ?[]const u8,

    /// Differentiates between delivery address and pickup address in the customer
    /// account. Provided at job creation.
    type: ?AddressType,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .city = "City",
        .company = "Company",
        .country = "Country",
        .is_restricted = "IsRestricted",
        .landmark = "Landmark",
        .name = "Name",
        .phone_number = "PhoneNumber",
        .postal_code = "PostalCode",
        .prefecture_or_district = "PrefectureOrDistrict",
        .state_or_province = "StateOrProvince",
        .street_1 = "Street1",
        .street_2 = "Street2",
        .street_3 = "Street3",
        .type = "Type",
    };
};
