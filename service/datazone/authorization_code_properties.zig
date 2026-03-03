/// The authorization code properties of a connection.
pub const AuthorizationCodeProperties = struct {
    /// The authorization code of a connection.
    authorization_code: ?[]const u8 = null,

    /// The redirect URI of a connection.
    redirect_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_code = "authorizationCode",
        .redirect_uri = "redirectUri",
    };
};
