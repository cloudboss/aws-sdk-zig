const ToolClassification = @import("tool_classification.zig").ToolClassification;

/// An MCP tool together with its access categorization.
pub const MCPToolDetail = struct {
    /// The name of the MCP tool.
    name: []const u8,

    /// The access categorization of the MCP tool.
    tool_classification: ?ToolClassification = null,

    pub const json_field_names = .{
        .name = "name",
        .tool_classification = "toolClassification",
    };
};
