/// An annotation for modifying an existing rule in an Automated Reasoning
/// policy.
pub const AutomatedReasoningPolicyUpdateRuleAnnotation = struct {
    /// The new formal logical expression for the rule, replacing the previous
    /// expression.
    expression: []const u8,

    /// The unique identifier of the rule to update.
    rule_id: []const u8,

    pub const json_field_names = .{
        .expression = "expression",
        .rule_id = "ruleId",
    };
};
