const ToolOverrideConstantInputValue = @import("tool_override_constant_input_value.zig").ToolOverrideConstantInputValue;

/// Configuration for overriding tool input values.
pub const ToolOverrideInputValueConfiguration = union(enum) {
    /// Constant input value configuration for tool override.
    constant: ?ToolOverrideConstantInputValue,

    pub const json_field_names = .{
        .constant = "constant",
    };
};
