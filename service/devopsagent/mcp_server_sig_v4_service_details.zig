const MCPServerSigV4AuthorizationConfig = @import("mcp_server_sig_v4_authorization_config.zig").MCPServerSigV4AuthorizationConfig;

/// Complete service details for SigV4-authenticated MCP server integration.
pub const MCPServerSigV4ServiceDetails = struct {
    /// MCP Server SigV4 authorization configuration.
    authorization_config: MCPServerSigV4AuthorizationConfig,

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
