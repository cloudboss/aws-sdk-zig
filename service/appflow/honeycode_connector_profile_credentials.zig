const ConnectorOAuthRequest = @import("connector_o_auth_request.zig").ConnectorOAuthRequest;

/// The connector-specific credentials required when using Amazon Honeycode.
pub const HoneycodeConnectorProfileCredentials = struct {
    /// The credentials used to access protected Amazon Honeycode resources.
    access_token: ?[]const u8,

    o_auth_request: ?ConnectorOAuthRequest,

    /// The credentials used to acquire new access tokens.
    refresh_token: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .o_auth_request = "oAuthRequest",
        .refresh_token = "refreshToken",
    };
};
