const aws = @import("aws");

const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// The OAuth 2.0 properties required for OAuth 2.0 authentication.
pub const OAuth2Properties = struct {
    /// The OAuth 2.0 grant type used by connector for OAuth 2.0 authentication.
    o_auth_2_grant_type: OAuth2GrantType,

    /// The token URL required for OAuth 2.0 authentication.
    token_url: []const u8,

    /// Associates your token URL with a map of properties that you define. Use this
    /// parameter to
    /// provide any additional details that the connector requires to authenticate
    /// your
    /// request.
    token_url_custom_properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .o_auth_2_grant_type = "oAuth2GrantType",
        .token_url = "tokenUrl",
        .token_url_custom_properties = "tokenUrlCustomProperties",
    };
};
