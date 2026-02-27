const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required when using Slack.
pub const SlackConnectorProfileCredentials = struct {
    /// The credentials used to access protected Slack resources.
    access_token: ?[]const u8,

    /// The identifier for the client.
    client_id: []const u8,

    /// The client secret used by the OAuth client to authenticate to the
    /// authorization server.
    client_secret: []const u8,

    /// The OAuth requirement needed to request security tokens from the connector
    /// endpoint.
    o_auth_request: ?ConnectorOAuthRequest,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .o_auth_request = "oAuthRequest",
    };
};
