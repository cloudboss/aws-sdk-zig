const AutomatedReasoningPolicyDefinitionType = @import("automated_reasoning_policy_definition_type.zig").AutomatedReasoningPolicyDefinitionType;

/// A mutation operation that adds a new custom type to the policy definition
/// during the build process.
pub const AutomatedReasoningPolicyAddTypeMutation = struct {
    /// The type definition that specifies the name, description, and possible
    /// values for the new custom type being added to the policy.
    @"type": AutomatedReasoningPolicyDefinitionType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
