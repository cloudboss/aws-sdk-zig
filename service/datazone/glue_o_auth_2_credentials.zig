/// The GlueOAuth2 credentials of a connection.
pub const GlueOAuth2Credentials = struct {
    /// The access token of a connection.
    access_token: ?[]const u8 = null,

    /// The jwt token of the connection.
    jwt_token: ?[]const u8 = null,

    /// The refresh token of the connection.
    refresh_token: ?[]const u8 = null,

    /// The user managed client application client secret of the connection.
    user_managed_client_application_client_secret: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .jwt_token = "jwtToken",
        .refresh_token = "refreshToken",
        .user_managed_client_application_client_secret = "userManagedClientApplicationClientSecret",
    };
};
