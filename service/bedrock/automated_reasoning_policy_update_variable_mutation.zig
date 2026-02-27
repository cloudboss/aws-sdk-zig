const AutomatedReasoningPolicyDefinitionVariable = @import("automated_reasoning_policy_definition_variable.zig").AutomatedReasoningPolicyDefinitionVariable;

/// A mutation operation that modifies an existing variable in the policy
/// definition during the build process.
pub const AutomatedReasoningPolicyUpdateVariableMutation = struct {
    /// The updated variable definition containing the modified name, type, or
    /// description for the existing variable.
    variable: AutomatedReasoningPolicyDefinitionVariable,

    pub const json_field_names = .{
        .variable = "variable",
    };
};
