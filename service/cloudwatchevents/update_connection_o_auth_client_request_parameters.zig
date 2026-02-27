/// Contains the OAuth authorization parameters to use for the connection.
pub const UpdateConnectionOAuthClientRequestParameters = struct {
    /// The client ID to use for OAuth authorization.
    client_id: ?[]const u8,

    /// The client secret assciated with the client ID to use for OAuth
    /// authorization.
    client_secret: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "ClientID",
        .client_secret = "ClientSecret",
    };
};
