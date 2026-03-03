const KeyLocation = @import("key_location.zig").KeyLocation;

/// Provides the configuration information for the JWT token type.
pub const JwtTokenTypeConfiguration = struct {
    /// The regular expression that identifies the claim.
    claim_regex: ?[]const u8 = null,

    /// The group attribute field.
    group_attribute_field: ?[]const u8 = null,

    /// The issuer of the token.
    issuer: ?[]const u8 = null,

    /// The location of the key.
    key_location: KeyLocation,

    /// The Amazon Resource Name (arn) of the secret.
    secret_manager_arn: ?[]const u8 = null,

    /// The signing key URL.
    url: ?[]const u8 = null,

    /// The user name attribute field.
    user_name_attribute_field: ?[]const u8 = null,

    pub const json_field_names = .{
        .claim_regex = "ClaimRegex",
        .group_attribute_field = "GroupAttributeField",
        .issuer = "Issuer",
        .key_location = "KeyLocation",
        .secret_manager_arn = "SecretManagerArn",
        .url = "URL",
        .user_name_attribute_field = "UserNameAttributeField",
    };
};
