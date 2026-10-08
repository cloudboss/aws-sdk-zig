const MCPServerAuthorizationMethod = @import("mcp_server_authorization_method.zig").MCPServerAuthorizationMethod;

/// Details specific to a registered Grafana server, used by the built-in MCP
/// server.
pub const RegisteredGrafanaServerDetails = struct {
    /// The authz method used by the MCP server.
    authorization_method: MCPServerAuthorizationMethod,

    /// Grafana instance URL (e.g., https://your-instance.grafana.net)
    endpoint: []const u8,

    pub const json_field_names = .{
        .authorization_method = "authorizationMethod",
        .endpoint = "endpoint",
    };
};
