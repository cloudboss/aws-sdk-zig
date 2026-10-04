/// The access token and its metadata from a machine-to-machine (M2M) client
/// credentials
/// grant.
pub const ClientAuthenticationResultType = struct {
    /// The access token for the requested app client. Present this token to a
    /// resource server
    /// to authorize a request, using the scopes granted in the token.
    access_token: ?[]const u8 = null,

    /// The number of seconds until the access token expires.
    expires_in: i32 = 0,

    /// The type of the token. For example, `Bearer`.
    token_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .expires_in = "ExpiresIn",
        .token_type = "TokenType",
    };
};
