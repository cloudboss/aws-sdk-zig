/// Contains the authorization server metadata for an OAuth2 provider.
pub const Oauth2AuthorizationServerMetadata = struct {
    /// The authorization endpoint URL for the OAuth2 authorization server.
    authorization_endpoint: []const u8,

    /// The issuer URL for the OAuth2 authorization server.
    issuer: []const u8,

    /// The supported response types for the OAuth2 authorization server.
    response_types: ?[]const []const u8 = null,

    /// The token endpoint URL for the OAuth2 authorization server.
    token_endpoint: []const u8,

    /// The authentication methods supported by the token endpoint. This specifies
    /// how clients can authenticate when requesting tokens from the authorization
    /// server.
    token_endpoint_auth_methods: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .authorization_endpoint = "authorizationEndpoint",
        .issuer = "issuer",
        .response_types = "responseTypes",
        .token_endpoint = "tokenEndpoint",
        .token_endpoint_auth_methods = "tokenEndpointAuthMethods",
    };
};
