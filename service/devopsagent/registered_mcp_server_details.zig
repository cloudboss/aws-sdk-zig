const MCPServerAuthorizationMethod = @import("mcp_server_authorization_method.zig").MCPServerAuthorizationMethod;

/// Details specific to a registered MCP (Model Context Protocol) server.
pub const RegisteredMCPServerDetails = struct {
    /// If the MCP server uses API key authentication, these details are provided.
    api_key_header: ?[]const u8 = null,

    /// The MCP server uses this authorization method.
    authorization_method: MCPServerAuthorizationMethod,

    /// Optional description for the MCP server.
    description: ?[]const u8 = null,

    /// The MCP server endpoint URL.
    endpoint: []const u8,

    /// The MCP server name.
    name: []const u8,

    pub const json_field_names = .{
        .api_key_header = "apiKeyHeader",
        .authorization_method = "authorizationMethod",
        .description = "description",
        .endpoint = "endpoint",
        .name = "name",
    };
};
