const aws = @import("aws");

/// OAuth 3-legged authorization configuration for MCP server.
pub const MCPServerOAuth3LOConfig = struct {
    /// OAuth authorization URL for 3LO authentication.
    authorization_url: []const u8,

    /// OAuth client ID for authenticating with the service.
    client_id: []const u8,

    /// User friendly OAuth client name specified by end user.
    client_name: ?[]const u8 = null,

    /// OAuth client secret for authenticating with the service. Required for
    /// confidential clients or when PKCE is not supported. Optional for public
    /// clients using PKCE.
    client_secret: ?[]const u8 = null,

    /// OAuth token exchange parameters for authenticating with the service.
    exchange_parameters: ?[]const aws.map.StringMapEntry = null,

    /// OAuth token exchange URL.
    exchange_url: []const u8,

    /// The endpoint to return to after OAuth flow completes (must be AWS console
    /// domain)
    return_to_endpoint: []const u8,

    /// OAuth scopes for 3LO authentication. The service will always request scope
    /// offline_access.
    scopes: ?[]const []const u8 = null,

    /// Whether the service supports PKCE (Proof Key for Code Exchange) for enhanced
    /// security during the OAuth flow.
    support_code_challenge: bool = false,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .client_id = "clientId",
        .client_name = "clientName",
        .client_secret = "clientSecret",
        .exchange_parameters = "exchangeParameters",
        .exchange_url = "exchangeUrl",
        .return_to_endpoint = "returnToEndpoint",
        .scopes = "scopes",
        .support_code_challenge = "supportCodeChallenge",
    };
};
