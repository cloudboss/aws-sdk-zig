const ToolDescriptionInput = @import("tool_description_input.zig").ToolDescriptionInput;

/// Inline tool description input containing a list of tools.
pub const ToolDescriptionTextInput = struct {
    /// The list of tool descriptions to optimize.
    tools: []const ToolDescriptionInput,

    pub const json_field_names = .{
        .tools = "tools",
    };
};
