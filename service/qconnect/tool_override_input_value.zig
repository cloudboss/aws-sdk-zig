const ToolOverrideInputValueConfiguration = @import("tool_override_input_value_configuration.zig").ToolOverrideInputValueConfiguration;

/// An input value override for tools.
pub const ToolOverrideInputValue = struct {
    /// The JSON path for the input value override.
    json_path: []const u8,

    /// The override input value.
    value: ToolOverrideInputValueConfiguration,

    pub const json_field_names = .{
        .json_path = "jsonPath",
        .value = "value",
    };
};
