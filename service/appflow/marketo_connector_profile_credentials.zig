const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required by Marketo.
pub const MarketoConnectorProfileCredentials = struct {
    /// The credentials used to access protected Marketo resources.
    access_token: ?[]const u8 = null,

    /// The identifier for the desired client.
    client_id: []const u8,

    /// The client secret used by the OAuth client to authenticate to the
    /// authorization server.
    client_secret: []const u8,

    /// The OAuth requirement needed to request security tokens from the connector
    /// endpoint.
    o_auth_request: ?ConnectorOAuthRequest = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .o_auth_request = "oAuthRequest",
    };
};
