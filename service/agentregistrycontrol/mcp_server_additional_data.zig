const McpToolsDescriptor = @import("mcp_tools_descriptor.zig").McpToolsDescriptor;

/// Additional data for an MCP server descriptor
pub const McpServerAdditionalData = struct {
    /// The MCP tools descriptor that defines the tools exposed by the MCP server.
    tools: ?McpToolsDescriptor = null,

    pub const json_field_names = .{
        .tools = "tools",
    };
};
