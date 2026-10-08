const MCPServerAPIKeyConfig = @import("mcp_server_api_key_config.zig").MCPServerAPIKeyConfig;
const MCPServerAuthorizationDiscoveryConfig = @import("mcp_server_authorization_discovery_config.zig").MCPServerAuthorizationDiscoveryConfig;
const MCPServerBearerTokenConfig = @import("mcp_server_bearer_token_config.zig").MCPServerBearerTokenConfig;
const MCPServerOAuth3LOConfig = @import("mcp_server_o_auth_3_lo_config.zig").MCPServerOAuth3LOConfig;
const MCPServerOAuthClientCredentialsConfig = @import("mcp_server_o_auth_client_credentials_config.zig").MCPServerOAuthClientCredentialsConfig;

/// Authorization configuration options for MCP server, supporting OAuth, API
/// key, bearer token, and authorization discovery methods.
pub const MCPServerAuthorizationConfig = union(enum) {
    /// MCP server configuration with API key authentication.
    api_key: ?MCPServerAPIKeyConfig,
    /// MCP server authorization discovery configuration.
    authorization_discovery: ?MCPServerAuthorizationDiscoveryConfig,
    /// MCP server configuration with Bearer token (RFC 6750).
    bearer_token: ?MCPServerBearerTokenConfig,
    /// MCP server configuration with OAuth 3LO.
    o_auth_3_lo: ?MCPServerOAuth3LOConfig,
    /// MCP server configuration with OAuth client credentials.
    o_auth_client_credentials: ?MCPServerOAuthClientCredentialsConfig,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .authorization_discovery = "authorizationDiscovery",
        .bearer_token = "bearerToken",
        .o_auth_3_lo = "oAuth3LO",
        .o_auth_client_credentials = "oAuthClientCredentials",
    };
};
