/// Read-only configuration details for OAuth2 client credentials grant flow,
/// including client ID and token endpoint.
pub const ReadClientCredentialsGrantDetails = struct {
    /// The client identifier for the OAuth2 client credentials grant flow.
    client_id: []const u8,

    /// The authorization server endpoint used to obtain access tokens via the
    /// client credentials grant flow.
    token_endpoint: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .token_endpoint = "TokenEndpoint",
    };
};
