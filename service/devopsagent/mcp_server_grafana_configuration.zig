const MCPToolDetail = @import("mcp_tool_detail.zig").MCPToolDetail;

/// Configuration for Grafana MCP server integration, used with an AWS-hosted
/// MCP server.
pub const MCPServerGrafanaConfiguration = struct {
    /// The subset of elevated-access tools enabled for this integration.
    enabled_elevated_tools: ?[]const MCPToolDetail = null,

    /// Grafana instance URL (e.g., https://your-instance.grafana.net)
    endpoint: []const u8,

    /// The Grafana organization ID that can be used.
    organization_id: ?[]const u8 = null,

    /// List of MCP tools that can be used.
    tools: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .enabled_elevated_tools = "enabledElevatedTools",
        .endpoint = "endpoint",
        .organization_id = "organizationId",
        .tools = "tools",
    };
};
