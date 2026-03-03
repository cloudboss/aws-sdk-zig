const NumberCapability = @import("number_capability.zig").NumberCapability;

/// The metadata for an origination identity associated with a pool.
pub const OriginationIdentityMetadata = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// Describes if the origination identity can be used for text messages, voice
    /// calls or both.
    number_capabilities: []const NumberCapability,

    /// The unique identifier of the origination identity.
    origination_identity: []const u8,

    /// The Amazon Resource Name (ARN) associated with the origination identity.
    origination_identity_arn: []const u8,

    /// The phone number in E.164 format.
    phone_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .number_capabilities = "NumberCapabilities",
        .origination_identity = "OriginationIdentity",
        .origination_identity_arn = "OriginationIdentityArn",
        .phone_number = "PhoneNumber",
    };
};
