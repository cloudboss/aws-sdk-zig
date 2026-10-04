const ToolReference = @import("tool_reference.zig").ToolReference;

/// A content block for removing a tool from the available tool set
/// mid-conversation. Each block references a single tool via its `tool` field.
/// Use within a `system` role message to remove a tool without re-sending the
/// full tool configuration.
pub const ToolRemovalBlock = struct {
    /// A reference to the tool to remove from the available tool set.
    tool: ToolReference,

    pub const json_field_names = .{
        .tool = "tool",
    };
};
