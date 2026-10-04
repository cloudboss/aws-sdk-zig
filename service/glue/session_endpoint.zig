/// Contains the Spark Connect endpoint details for an interactive session,
/// including the URL and authentication credentials.
pub const SessionEndpoint = struct {
    /// The authentication token to include in requests to the Spark Connect
    /// endpoint.
    auth_token: []const u8,

    /// The time at which the authentication token expires.
    auth_token_expiration_time: i64,

    /// The Spark Connect endpoint URL for the session.
    url: []const u8,

    pub const json_field_names = .{
        .auth_token = "AuthToken",
        .auth_token_expiration_time = "AuthTokenExpirationTime",
        .url = "Url",
    };
};
