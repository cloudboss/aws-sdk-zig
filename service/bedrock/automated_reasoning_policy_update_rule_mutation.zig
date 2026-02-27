const AutomatedReasoningPolicyDefinitionRule = @import("automated_reasoning_policy_definition_rule.zig").AutomatedReasoningPolicyDefinitionRule;

/// A mutation operation that modifies an existing rule in the policy definition
/// during the build process.
pub const AutomatedReasoningPolicyUpdateRuleMutation = struct {
    /// The updated rule definition containing the modified formal logical
    /// expression and any changed metadata for the existing rule.
    rule: AutomatedReasoningPolicyDefinitionRule,

    pub const json_field_names = .{
        .rule = "rule",
    };
};
