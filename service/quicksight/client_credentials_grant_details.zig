/// Configuration details for OAuth2 client credentials grant flow, including
/// client ID, client secret, token endpoint, and optional scopes.
pub const ClientCredentialsGrantDetails = struct {
    /// The client identifier issued to the client during the registration process
    /// with the authorization server.
    client_id: []const u8,

    /// The client secret issued to the client during the registration process with
    /// the authorization server.
    client_secret: []const u8,

    /// The authorization server endpoint used to obtain access tokens via the
    /// client credentials grant flow.
    token_endpoint: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .token_endpoint = "TokenEndpoint",
    };
};
