const AutomatedReasoningPolicyDefinitionVariable = @import("automated_reasoning_policy_definition_variable.zig").AutomatedReasoningPolicyDefinitionVariable;

/// A mutation operation that adds a new variable to the policy definition
/// during the build process.
pub const AutomatedReasoningPolicyAddVariableMutation = struct {
    /// The variable definition that specifies the name, type, and description for
    /// the new variable being added to the policy.
    variable: AutomatedReasoningPolicyDefinitionVariable,

    pub const json_field_names = .{
        .variable = "variable",
    };
};
