/// Configuration details for OAuth 2.0 authorization code grant flow.
pub const AuthorizationCodeGrantDetails = struct {
    /// The authorization endpoint URL for the OAuth flow.
    authorization_endpoint: []const u8,

    /// The client ID for the OAuth application.
    client_id: []const u8,

    /// The client secret for the OAuth application.
    client_secret: []const u8,

    /// The token endpoint URL for obtaining access tokens.
    token_endpoint: []const u8,

    pub const json_field_names = .{
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .token_endpoint = "TokenEndpoint",
    };
};
