const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// The phone number country.
pub const PhoneNumberCountry = struct {
    /// The phone number country code. Format: ISO 3166-1 alpha-2.
    country_code: ?[]const u8,

    /// The supported phone number types.
    supported_phone_number_types: ?[]const PhoneNumberType,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .supported_phone_number_types = "SupportedPhoneNumberTypes",
    };
};
