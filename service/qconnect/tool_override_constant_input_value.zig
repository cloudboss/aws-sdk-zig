const ToolOverrideInputValueType = @import("tool_override_input_value_type.zig").ToolOverrideInputValueType;

/// A constant input value for tool override.
pub const ToolOverrideConstantInputValue = struct {
    /// Override tool input value with constant values
    @"type": ToolOverrideInputValueType,

    /// The constant input override value.
    value: []const u8,

    pub const json_field_names = .{
        .@"type" = "type",
        .value = "value",
    };
};
