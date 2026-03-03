/// Describes a refresh token.
pub const RefreshTokenRequestBody = struct {
    /// The ID of the client to request the token from.
    client_id: ?[]const u8 = null,

    /// The token to use to refresh a previously issued access token that might have
    /// expired.
    token: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .token = "token",
    };
};
