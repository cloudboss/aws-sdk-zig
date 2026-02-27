const AutomatedReasoningPolicyDefinitionRule = @import("automated_reasoning_policy_definition_rule.zig").AutomatedReasoningPolicyDefinitionRule;

/// A mutation operation that adds a new rule to the policy definition during
/// the build process.
pub const AutomatedReasoningPolicyAddRuleMutation = struct {
    /// The rule definition that specifies the formal logical expression and
    /// metadata for the new rule being added to the policy.
    rule: AutomatedReasoningPolicyDefinitionRule,

    pub const json_field_names = .{
        .rule = "rule",
    };
};
