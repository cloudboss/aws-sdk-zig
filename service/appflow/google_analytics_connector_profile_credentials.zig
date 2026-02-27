const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required by Google Analytics.
pub const GoogleAnalyticsConnectorProfileCredentials = struct {
    /// The credentials used to access protected Google Analytics resources.
    access_token: ?[]const u8,

    /// The identifier for the desired client.
    client_id: []const u8,

    /// The client secret used by the OAuth client to authenticate to the
    /// authorization server.
    client_secret: []const u8,

    /// The OAuth requirement needed to request security tokens from the connector
    /// endpoint.
    o_auth_request: ?ConnectorOAuthRequest,

    /// The credentials used to acquire new access tokens. This is required only for
    /// OAuth2
    /// access tokens, and is not required for OAuth1 access tokens.
    refresh_token: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .o_auth_request = "oAuthRequest",
        .refresh_token = "refreshToken",
    };
};
