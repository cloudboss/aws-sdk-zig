/// The credentials used when the authentication type is OAuth2 authentication.
pub const OAuth2Credentials = struct {
    /// The access token used when the authentication type is OAuth2.
    access_token: ?[]const u8,

    /// The JSON Web Token (JWT) used when the authentication type is OAuth2.
    jwt_token: ?[]const u8,

    /// The refresh token used when the authentication type is OAuth2.
    refresh_token: ?[]const u8,

    /// The client application client secret if the client application is user
    /// managed.
    user_managed_client_application_client_secret: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .jwt_token = "JwtToken",
        .refresh_token = "RefreshToken",
        .user_managed_client_application_client_secret = "UserManagedClientApplicationClientSecret",
    };
};
