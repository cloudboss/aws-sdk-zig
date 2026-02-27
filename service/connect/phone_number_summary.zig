const PhoneNumberCountryCode = @import("phone_number_country_code.zig").PhoneNumberCountryCode;
const PhoneNumberType = @import("phone_number_type.zig").PhoneNumberType;

/// Contains summary information about a phone number for a contact center.
pub const PhoneNumberSummary = struct {
    /// The Amazon Resource Name (ARN) of the phone number.
    arn: ?[]const u8,

    /// The identifier of the phone number.
    id: ?[]const u8,

    /// The phone number.
    phone_number: ?[]const u8,

    /// The ISO country code.
    phone_number_country_code: ?PhoneNumberCountryCode,

    /// The type of phone number.
    phone_number_type: ?PhoneNumberType,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .phone_number = "PhoneNumber",
        .phone_number_country_code = "PhoneNumberCountryCode",
        .phone_number_type = "PhoneNumberType",
    };
};
