const ToolReference = @import("tool_reference.zig").ToolReference;

/// A content block for adding a tool to the available tool set
/// mid-conversation. Each block references a single tool via its `tool` field.
/// Use within a `system` role message to make a tool available without
/// re-sending the full tool configuration.
pub const ToolAdditionBlock = struct {
    /// A reference to the tool to add to the available tool set.
    tool: ToolReference,

    pub const json_field_names = .{
        .tool = "tool",
    };
};
