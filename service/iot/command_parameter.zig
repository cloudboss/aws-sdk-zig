const CommandParameterValue = @import("command_parameter_value.zig").CommandParameterValue;
const CommandParameterType = @import("command_parameter_type.zig").CommandParameterType;
const CommandParameterValueCondition = @import("command_parameter_value_condition.zig").CommandParameterValueCondition;

/// A map of key-value pairs that describe the command.
pub const CommandParameter = struct {
    /// The default value used to describe the command. This is the value assumed by
    /// the
    /// parameter if no other value is assigned to it.
    default_value: ?CommandParameterValue = null,

    /// The description of the command parameter.
    description: ?[]const u8 = null,

    /// The name of a specific parameter used in a command and command execution.
    name: []const u8,

    /// The type of the command parameter.
    @"type": ?CommandParameterType = null,

    /// Parameter value that overrides the default value, if set.
    value: ?CommandParameterValue = null,

    /// The list of conditions that a command parameter value must satisfy to create
    /// a command execution.
    value_conditions: ?[]const CommandParameterValueCondition = null,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
        .@"type" = "type",
        .value = "value",
        .value_conditions = "valueConditions",
    };
};
