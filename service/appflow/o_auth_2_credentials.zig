const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The OAuth 2.0 credentials required for OAuth 2.0 authentication.
pub const OAuth2Credentials = struct {
    /// The access token used to access the connector on your behalf.
    access_token: ?[]const u8 = null,

    /// The identifier for the desired client.
    client_id: ?[]const u8 = null,

    /// The client secret used by the OAuth client to authenticate to the
    /// authorization
    /// server.
    client_secret: ?[]const u8 = null,

    o_auth_request: ?ConnectorOAuthRequest = null,

    /// The refresh token used to refresh an expired access token.
    refresh_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .o_auth_request = "oAuthRequest",
        .refresh_token = "refreshToken",
    };
};
