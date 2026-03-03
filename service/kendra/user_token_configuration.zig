const JsonTokenTypeConfiguration = @import("json_token_type_configuration.zig").JsonTokenTypeConfiguration;
const JwtTokenTypeConfiguration = @import("jwt_token_type_configuration.zig").JwtTokenTypeConfiguration;

/// Provides the configuration information for a token.
///
/// If you're using an Amazon Kendra Gen AI Enterprise Edition index and you try
/// to use
/// `UserTokenConfigurations` to configure user context policy, Amazon Kendra
/// returns
/// a `ValidationException` error.
pub const UserTokenConfiguration = struct {
    /// Information about the JSON token type configuration.
    json_token_type_configuration: ?JsonTokenTypeConfiguration = null,

    /// Information about the JWT token type configuration.
    jwt_token_type_configuration: ?JwtTokenTypeConfiguration = null,

    pub const json_field_names = .{
        .json_token_type_configuration = "JsonTokenTypeConfiguration",
        .jwt_token_type_configuration = "JwtTokenTypeConfiguration",
    };
};
