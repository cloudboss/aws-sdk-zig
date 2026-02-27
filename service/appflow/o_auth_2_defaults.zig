const OAuth2CustomParameter = @import("o_auth_2_custom_parameter.zig").OAuth2CustomParameter;
const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// Contains the default values required for OAuth 2.0 authentication.
pub const OAuth2Defaults = struct {
    /// Auth code URLs that can be used for OAuth 2.0 authentication.
    auth_code_urls: ?[]const []const u8,

    /// List of custom parameters required for OAuth 2.0 authentication.
    oauth_2_custom_properties: ?[]const OAuth2CustomParameter,

    /// OAuth 2.0 grant types supported by the connector.
    oauth_2_grant_types_supported: ?[]const OAuth2GrantType,

    /// OAuth 2.0 scopes that the connector supports.
    oauth_scopes: ?[]const []const u8,

    /// Token URLs that can be used for OAuth 2.0 authentication.
    token_urls: ?[]const []const u8,

    pub const json_field_names = .{
        .auth_code_urls = "authCodeUrls",
        .oauth_2_custom_properties = "oauth2CustomProperties",
        .oauth_2_grant_types_supported = "oauth2GrantTypesSupported",
        .oauth_scopes = "oauthScopes",
        .token_urls = "tokenUrls",
    };
};
