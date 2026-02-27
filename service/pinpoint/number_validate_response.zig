/// Provides information about a phone number.
pub const NumberValidateResponse = struct {
    /// The carrier or service provider that the phone number is currently
    /// registered with. In some countries and regions, this value may be the
    /// carrier or service provider that the phone number was originally registered
    /// with.
    carrier: ?[]const u8,

    /// The name of the city where the phone number was originally registered.
    city: ?[]const u8,

    /// The cleansed phone number, in E.164 format, for the location where the phone
    /// number was originally registered.
    cleansed_phone_number_e164: ?[]const u8,

    /// The cleansed phone number, in the format for the location where the phone
    /// number was originally registered.
    cleansed_phone_number_national: ?[]const u8,

    /// The name of the country or region where the phone number was originally
    /// registered.
    country: ?[]const u8,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region where the phone number was originally registered.
    country_code_iso_2: ?[]const u8,

    /// The numeric code for the country or region where the phone number was
    /// originally registered.
    country_code_numeric: ?[]const u8,

    /// The name of the county where the phone number was originally registered.
    county: ?[]const u8,

    /// The two-character code, in ISO 3166-1 alpha-2 format, that was sent in the
    /// request body.
    original_country_code_iso_2: ?[]const u8,

    /// The phone number that was sent in the request body.
    original_phone_number: ?[]const u8,

    /// The description of the phone type. Valid values are: MOBILE, LANDLINE, VOIP,
    /// INVALID, PREPAID, and OTHER.
    phone_type: ?[]const u8,

    /// The phone type, represented by an integer. Valid values are: 0 (mobile), 1
    /// (landline), 2 (VoIP), 3 (invalid), 4 (other), and 5 (prepaid).
    phone_type_code: ?i32,

    /// The time zone for the location where the phone number was originally
    /// registered.
    timezone: ?[]const u8,

    /// The postal or ZIP code for the location where the phone number was
    /// originally registered.
    zip_code: ?[]const u8,

    pub const json_field_names = .{
        .carrier = "Carrier",
        .city = "City",
        .cleansed_phone_number_e164 = "CleansedPhoneNumberE164",
        .cleansed_phone_number_national = "CleansedPhoneNumberNational",
        .country = "Country",
        .country_code_iso_2 = "CountryCodeIso2",
        .country_code_numeric = "CountryCodeNumeric",
        .county = "County",
        .original_country_code_iso_2 = "OriginalCountryCodeIso2",
        .original_phone_number = "OriginalPhoneNumber",
        .phone_type = "PhoneType",
        .phone_type_code = "PhoneTypeCode",
        .timezone = "Timezone",
        .zip_code = "ZipCode",
    };
};
