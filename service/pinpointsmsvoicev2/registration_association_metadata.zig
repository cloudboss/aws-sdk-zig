/// Metadata for the origination identity that is associated with the
/// registration.
pub const RegistrationAssociationMetadata = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8,

    /// The phone number associated with the registration in E.164 format.
    phone_number: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the origination identity that is
    /// associated with the registration.
    resource_arn: []const u8,

    /// The unique identifier for the origination identity. For example this could
    /// be a **PhoneNumberId** or **SenderId**.
    resource_id: []const u8,

    /// The origination identity type.
    resource_type: []const u8,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .phone_number = "PhoneNumber",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
