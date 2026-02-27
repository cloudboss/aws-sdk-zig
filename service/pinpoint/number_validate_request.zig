/// Specifies a phone number to validate and retrieve information about.
pub const NumberValidateRequest = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region where the phone number was originally registered.
    iso_country_code: ?[]const u8,

    /// The phone number to retrieve information about. The phone number that you
    /// provide should include a valid numeric country code. Otherwise, the
    /// operation might result in an error.
    phone_number: ?[]const u8,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .phone_number = "PhoneNumber",
    };
};
