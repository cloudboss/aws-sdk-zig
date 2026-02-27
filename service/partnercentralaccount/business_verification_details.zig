/// Contains the business information required for verifying a company's legal
/// status and registration details within AWS Partner Central.
pub const BusinessVerificationDetails = struct {
    /// The ISO 3166-1 alpha-2 country code where the business is legally registered
    /// and operates.
    country_code: []const u8,

    /// The specific legal jurisdiction or state where the business was incorporated
    /// or registered, providing additional location context beyond the country
    /// code.
    jurisdiction_of_incorporation: ?[]const u8,

    /// The official legal name of the business as registered with the appropriate
    /// government authorities.
    legal_name: []const u8,

    /// The unique business registration identifier assigned by the government or
    /// regulatory authority, such as a company registration number or tax
    /// identification number.
    registration_id: []const u8,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .jurisdiction_of_incorporation = "JurisdictionOfIncorporation",
        .legal_name = "LegalName",
        .registration_id = "RegistrationId",
    };
};
