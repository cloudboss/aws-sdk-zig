const aws = @import("aws");

/// OAuth client credentials configuration for remote A2A agent.
pub const RemoteAgentOAuthClientCredentialsConfig = struct {
    /// OAuth client ID for authenticating with the service.
    client_id: []const u8,

    /// User friendly OAuth client name specified by end user.
    client_name: ?[]const u8 = null,

    /// OAuth client secret for authenticating with the service.
    client_secret: []const u8,

    /// OAuth token exchange parameters for authenticating with the service.
    exchange_parameters: ?[]const aws.map.StringMapEntry = null,

    /// OAuth token exchange URL.
    exchange_url: []const u8,

    /// OAuth scopes for authentication.
    scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_name = "clientName",
        .client_secret = "clientSecret",
        .exchange_parameters = "exchangeParameters",
        .exchange_url = "exchangeUrl",
        .scopes = "scopes",
    };
};
