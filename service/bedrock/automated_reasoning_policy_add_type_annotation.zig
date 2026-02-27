const AutomatedReasoningPolicyDefinitionTypeValue = @import("automated_reasoning_policy_definition_type_value.zig").AutomatedReasoningPolicyDefinitionTypeValue;

/// An annotation for adding a new custom type to an Automated Reasoning policy,
/// defining a set of possible values for variables.
pub const AutomatedReasoningPolicyAddTypeAnnotation = struct {
    /// A description of what the custom type represents and how it should be used
    /// in the policy.
    description: []const u8,

    /// The name of the new custom type. This name will be used to reference the
    /// type in variable definitions and rules.
    name: []const u8,

    /// The list of possible values that variables of this type can take, each with
    /// its own description and identifier.
    values: []const AutomatedReasoningPolicyDefinitionTypeValue,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .values = "values",
    };
};
