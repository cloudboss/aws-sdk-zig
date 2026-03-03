const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific profile credentials required when using Salesforce
/// Pardot.
pub const PardotConnectorProfileCredentials = struct {
    /// The credentials used to access protected Salesforce Pardot resources.
    access_token: ?[]const u8 = null,

    /// The secret manager ARN, which contains the client ID and client secret of
    /// the connected
    /// app.
    client_credentials_arn: ?[]const u8 = null,

    o_auth_request: ?ConnectorOAuthRequest = null,

    /// The credentials used to acquire new access tokens.
    refresh_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .client_credentials_arn = "clientCredentialsArn",
        .o_auth_request = "oAuthRequest",
        .refresh_token = "refreshToken",
    };
};
