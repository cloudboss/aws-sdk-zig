const AutomatedReasoningPolicyDefinitionType = @import("automated_reasoning_policy_definition_type.zig").AutomatedReasoningPolicyDefinitionType;

/// A mutation operation that modifies an existing custom type in the policy
/// definition during the build process.
pub const AutomatedReasoningPolicyUpdateTypeMutation = struct {
    /// The updated type definition containing the modified name, description, or
    /// values for the existing custom type.
    type: AutomatedReasoningPolicyDefinitionType,

    pub const json_field_names = .{
        .type = "type",
    };
};
