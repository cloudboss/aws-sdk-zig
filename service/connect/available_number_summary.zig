const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// Information about available phone numbers.
pub const AvailableNumberSummary = struct {
    /// The phone number. Phone numbers are formatted `[+] [country code]
    /// [subscriber number including area code]`.
    phone_number: ?[]const u8,

    /// The ISO country code.
    phone_number_country_code: ?PhoneNumberCountryCode,

    /// The type of phone number.
    phone_number_type: ?PhoneNumberType,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
        .phone_number_country_code = "PhoneNumberCountryCode",
        .phone_number_type = "PhoneNumberType",
    };
};
