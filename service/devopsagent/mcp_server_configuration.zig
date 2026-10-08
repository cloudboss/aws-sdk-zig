const MCPToolDetail = @import("mcp_tool_detail.zig").MCPToolDetail;

/// Configuration for Model Context Protocol (MCP) server integration.
pub const MCPServerConfiguration = struct {
    /// List of MCP tools with their access categorization. When provided, the tool
    /// names must match those in the tools member.
    tool_details: ?[]const MCPToolDetail = null,

    /// List of MCP tools can be used with the association.
    tools: []const []const u8,

    pub const json_field_names = .{
        .tool_details = "toolDetails",
        .tools = "tools",
    };
};
