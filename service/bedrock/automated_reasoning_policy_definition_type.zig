const AutomatedReasoningPolicyDefinitionTypeValue = @import("automated_reasoning_policy_definition_type_value.zig").AutomatedReasoningPolicyDefinitionTypeValue;

/// Represents a custom user-defined viarble type in an Automated Reasoning
/// policy. Types are enum-based and provide additional context beyond
/// predefined variable types.
pub const AutomatedReasoningPolicyDefinitionType = struct {
    /// The description of what the custom type represents.
    description: ?[]const u8 = null,

    /// The name of the custom type.
    name: []const u8,

    /// The possible values for this enum-based type, each with its own description.
    values: []const AutomatedReasoningPolicyDefinitionTypeValue,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .values = "values",
    };
};
