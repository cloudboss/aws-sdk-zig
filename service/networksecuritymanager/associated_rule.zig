/// An association between a template and a rule, as returned in outputs. The
/// corresponding request structure is `RuleReference`.
pub const AssociatedRule = struct {
    /// The ARN of the associated rule.
    rule_arn: []const u8,

    pub const json_field_names = .{
        .rule_arn = "ruleArn",
    };
};
