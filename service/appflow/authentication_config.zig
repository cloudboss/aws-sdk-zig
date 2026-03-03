const CustomAuthConfig = @import("custom_auth_config.zig").CustomAuthConfig;
const OAuth2Defaults = @import("o_auth_2_defaults.zig").OAuth2Defaults;

/// Contains information about the authentication config that the connector
/// supports.
pub const AuthenticationConfig = struct {
    /// Contains information required for custom authentication.
    custom_auth_configs: ?[]const CustomAuthConfig = null,

    /// Indicates whether API key authentication is supported by the connector
    is_api_key_auth_supported: bool = false,

    /// Indicates whether basic authentication is supported by the connector.
    is_basic_auth_supported: bool = false,

    /// Indicates whether custom authentication is supported by the connector
    is_custom_auth_supported: bool = false,

    /// Indicates whether OAuth 2.0 authentication is supported by the connector.
    is_o_auth_2_supported: bool = false,

    /// Contains the default values required for OAuth 2.0 authentication.
    o_auth_2_defaults: ?OAuth2Defaults = null,

    pub const json_field_names = .{
        .custom_auth_configs = "customAuthConfigs",
        .is_api_key_auth_supported = "isApiKeyAuthSupported",
        .is_basic_auth_supported = "isBasicAuthSupported",
        .is_custom_auth_supported = "isCustomAuthSupported",
        .is_o_auth_2_supported = "isOAuth2Supported",
        .o_auth_2_defaults = "oAuth2Defaults",
    };
};
