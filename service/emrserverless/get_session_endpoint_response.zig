pub const GetSessionEndpointResponse = struct {
    /// The output contains the ID of the application.
    application_id: []const u8,

    /// The authentication token for connecting to the session endpoint. Call
    /// `GetSessionEndpoint` again to obtain a new token before it expires.
    auth_token: []const u8,

    /// The expiration time of the authentication token.
    auth_token_expires_at: i64,

    /// The endpoint URL for connecting to the session.
    endpoint: []const u8,

    /// The output contains the ID of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .auth_token = "authToken",
        .auth_token_expires_at = "authTokenExpiresAt",
        .endpoint = "endpoint",
        .session_id = "sessionId",
    };
};
