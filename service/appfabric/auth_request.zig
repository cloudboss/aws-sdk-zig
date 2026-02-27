/// Contains authorization request information, which is required for Amazon Web
/// Services AppFabric to get the
/// OAuth2 access token for an application.
pub const AuthRequest = struct {
    /// The authorization code returned by the application after permission is
    /// granted in the
    /// application OAuth page (after clicking on the AuthURL).
    code: []const u8,

    /// The redirect URL that is specified in the AuthURL and the application
    /// client.
    redirect_uri: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .redirect_uri = "redirectUri",
    };
};
