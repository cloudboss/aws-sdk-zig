const ToolDescriptionConfig = @import("tool_description_config.zig").ToolDescriptionConfig;

/// A tool description input containing the tool name and its current
/// description.
pub const ToolDescriptionInput = struct {
    /// The current description of the tool to optimize.
    tool_description: ToolDescriptionConfig,

    /// The name of the tool.
    tool_name: []const u8,

    pub const json_field_names = .{
        .tool_description = "toolDescription",
        .tool_name = "toolName",
    };
};
