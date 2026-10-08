const MCPToolDetail = @import("mcp_tool_detail.zig").MCPToolDetail;

/// Configuration for SigV4-authenticated MCP server integration.
pub const MCPServerSigV4Configuration = struct {
    /// List of MCP tools with their access categorization. When provided, the tool
    /// names must match those in the tools member.
    tool_details: ?[]const MCPToolDetail = null,

    /// List of MCP tools available for the association.
    tools: []const []const u8,

    pub const json_field_names = .{
        .tool_details = "toolDetails",
        .tools = "tools",
    };
};
