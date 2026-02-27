/// Contains credentials to use for federation.
pub const Credentials = struct {
    /// An access token generated for a federated user to access Amazon Connect.
    access_token: ?[]const u8,

    /// A token generated with an expiration time for the session a user is logged
    /// in to Amazon Connect.
    access_token_expiration: ?i64,

    /// Renews a token generated for a user to access the Amazon Connect instance.
    refresh_token: ?[]const u8,

    /// Renews the expiration timer for a generated token.
    refresh_token_expiration: ?i64,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .access_token_expiration = "AccessTokenExpiration",
        .refresh_token = "RefreshToken",
        .refresh_token_expiration = "RefreshTokenExpiration",
    };
};
