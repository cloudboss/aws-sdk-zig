/// Contains OAuth2 client credential information.
pub const Oauth2Credential = struct {
    /// The client ID of the client application.
    client_id: []const u8,

    /// The client secret of the client application.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
