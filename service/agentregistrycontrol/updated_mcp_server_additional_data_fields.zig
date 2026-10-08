const UpdatedMcpToolsDescriptor = @import("updated_mcp_tools_descriptor.zig").UpdatedMcpToolsDescriptor;

/// The set of MCP server additional-data fields that can be individually
/// updated.
pub const UpdatedMcpServerAdditionalDataFields = struct {
    /// The patch for the MCP tools descriptor field.
    tools: ?UpdatedMcpToolsDescriptor = null,

    pub const json_field_names = .{
        .tools = "tools",
    };
};
