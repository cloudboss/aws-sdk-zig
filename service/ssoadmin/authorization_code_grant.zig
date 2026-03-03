/// A structure that defines configuration settings for an application that
/// supports the OAuth 2.0 Authorization Code Grant.
pub const AuthorizationCodeGrant = struct {
    /// A list of URIs that are valid locations to redirect a user's browser after
    /// the user is authorized.
    ///
    /// RedirectUris is required when the grant type is `authorization_code`.
    redirect_uris: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .redirect_uris = "RedirectUris",
    };
};
