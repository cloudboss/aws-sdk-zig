/// An annotation for removing a rule from an Automated Reasoning policy.
pub const AutomatedReasoningPolicyDeleteRuleAnnotation = struct {
    /// The unique identifier of the rule to delete from the policy.
    rule_id: []const u8,

    pub const json_field_names = .{
        .rule_id = "ruleId",
    };
};
