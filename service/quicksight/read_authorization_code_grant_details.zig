/// Read-only configuration details for OAuth2 authorization code grant flow,
/// including endpoints and client information.
pub const ReadAuthorizationCodeGrantDetails = struct {
    /// The authorization server endpoint used to obtain authorization codes from
    /// the resource owner.
    authorization_endpoint: []const u8,

    /// The client identifier for the OAuth2 authorization code grant flow.
    client_id: []const u8,

    /// The authorization server endpoint used to obtain access tokens via the
    /// authorization code grant flow.
    token_endpoint: []const u8,

    pub const json_field_names = .{
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_id = "ClientId",
        .token_endpoint = "TokenEndpoint",
    };
};
