const MCPServerAuthorizationDiscoveryConfig = @import("mcp_server_authorization_discovery_config.zig").MCPServerAuthorizationDiscoveryConfig;

/// Authorization configuration for Datadog MCP server (uses authorization
/// discovery only).
pub const DatadogAuthorizationConfig = union(enum) {
    /// Datadog MCP server authorization discovery configuration.
    authorization_discovery: ?MCPServerAuthorizationDiscoveryConfig,

    pub const json_field_names = .{
        .authorization_discovery = "authorizationDiscovery",
    };
};
