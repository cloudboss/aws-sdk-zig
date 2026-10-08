const MCPServerAuthorizationConfig = @import("mcp_server_authorization_config.zig").MCPServerAuthorizationConfig;

/// Complete service details for MCP server integration.
pub const MCPServerDetails = struct {
    /// MCP server authorization configuration.
    authorization_config: MCPServerAuthorizationConfig,

    /// Optional description for the MCP server.
    description: ?[]const u8 = null,

    /// MCP server endpoint URL.
    endpoint: []const u8,

    /// MCP server name.
    name: []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
    };
};
