/// Configuration settings for connecting to a supported OAuth2 provider. This
/// includes client credentials and OAuth2 discovery information for providers
/// that have built-in support.
pub const IncludedOauth2ProviderConfigInput = struct {
    /// OAuth2 authorization endpoint for your isolated OAuth2 application tenant.
    /// This is where users are redirected to authenticate and authorize access to
    /// their resources.
    authorization_endpoint: ?[]const u8 = null,

    /// The client ID for the supported OAuth2 provider. This identifier is assigned
    /// by the OAuth2 provider when you register your application.
    client_id: []const u8,

    /// The client secret for the supported OAuth2 provider. This secret is assigned
    /// by the OAuth2 provider and used along with the client ID to authenticate
    /// your application.
    client_secret: []const u8,

    /// Token issuer of your isolated OAuth2 application tenant. This URL identifies
    /// the authorization server that issues tokens for this provider.
    issuer: ?[]const u8 = null,

    /// OAuth2 token endpoint for your isolated OAuth2 application tenant. This is
    /// where authorization codes are exchanged for access tokens.
    token_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_endpoint = "authorizationEndpoint",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .issuer = "issuer",
        .token_endpoint = "tokenEndpoint",
    };
};
