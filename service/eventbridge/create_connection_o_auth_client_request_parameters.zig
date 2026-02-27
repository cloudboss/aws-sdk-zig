/// The Basic authorization parameters to use for the connection.
pub const CreateConnectionOAuthClientRequestParameters = struct {
    /// The client ID to use for OAuth authorization for the connection.
    client_id: []const u8,

    /// The client secret associated with the client ID to use for OAuth
    /// authorization for the
    /// connection.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientID",
        .client_secret = "ClientSecret",
    };
};
