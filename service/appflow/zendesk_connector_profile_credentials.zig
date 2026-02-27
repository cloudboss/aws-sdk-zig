const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required when using Zendesk.
pub const ZendeskConnectorProfileCredentials = struct {
    /// The credentials used to access protected Zendesk resources.
    access_token: ?[]const u8,

    /// The identifier for the desired client.
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
