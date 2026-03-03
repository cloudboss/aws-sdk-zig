const ApiKeyCredentials = @import("api_key_credentials.zig").ApiKeyCredentials;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const BasicAuthCredentials = @import("basic_auth_credentials.zig").BasicAuthCredentials;
const CustomAuthCredentials = @import("custom_auth_credentials.zig").CustomAuthCredentials;
const OAuth2Credentials = @import("o_auth_2_credentials.zig").OAuth2Credentials;

/// The connector-specific profile credentials that are required when using the
/// custom
/// connector.
pub const CustomConnectorProfileCredentials = struct {
    /// The API keys required for the authentication of the user.
    api_key: ?ApiKeyCredentials = null,

    /// The authentication type that the custom connector uses for authenticating
    /// while creating a
    /// connector profile.
    authentication_type: AuthenticationType,

    /// The basic credentials that are required for the authentication of the user.
    basic: ?BasicAuthCredentials = null,

    /// If the connector uses the custom authentication mechanism, this holds the
    /// required
    /// credentials.
    custom: ?CustomAuthCredentials = null,

    /// The OAuth 2.0 credentials required for the authentication of the user.
    oauth_2: ?OAuth2Credentials = null,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .authentication_type = "authenticationType",
        .basic = "basic",
        .custom = "custom",
        .oauth_2 = "oauth2",
    };
};
