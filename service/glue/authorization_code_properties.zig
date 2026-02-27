/// The set of properties required for the the OAuth2 `AUTHORIZATION_CODE` grant
/// type workflow.
pub const AuthorizationCodeProperties = struct {
    /// An authorization code to be used in the third leg of the
    /// `AUTHORIZATION_CODE` grant workflow. This is a single-use code which becomes
    /// invalid once exchanged for an access token, thus it is acceptable to have
    /// this value as a request parameter.
    authorization_code: ?[]const u8,

    /// The redirect URI where the user gets redirected to by authorization server
    /// when issuing an authorization code. The URI is subsequently used when the
    /// authorization code is exchanged for an access token.
    redirect_uri: ?[]const u8,

    pub const json_field_names = .{
        .authorization_code = "AuthorizationCode",
        .redirect_uri = "RedirectUri",
    };
};
