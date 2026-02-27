/// The OAuth properties required for OAuth type authentication.
pub const OAuthProperties = struct {
    /// The authorization code url required to redirect to SAP Login Page to fetch
    /// authorization
    /// code for OAuth type authentication.
    auth_code_url: []const u8,

    /// The OAuth scopes required for OAuth type authentication.
    o_auth_scopes: []const []const u8,

    /// The token url required to fetch access/refresh tokens using authorization
    /// code and also
    /// to refresh expired access token using refresh token.
    token_url: []const u8,

    pub const json_field_names = .{
        .auth_code_url = "authCodeUrl",
        .o_auth_scopes = "oAuthScopes",
        .token_url = "tokenUrl",
    };
};
