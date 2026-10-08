/// An association between a policy and either a template or a rule, as returned
/// in outputs. Exactly one of `templateArn` or `ruleArn` is set. The
/// corresponding request structure is `TemplateOrRuleReference`.
pub const AssociatedTemplateOrRule = union(enum) {
    /// The ARN of the associated rule.
    rule_arn: ?[]const u8,
    /// The ARN of the associated template.
    template_arn: ?[]const u8,

    pub const json_field_names = .{
        .rule_arn = "ruleArn",
        .template_arn = "templateArn",
    };
};
