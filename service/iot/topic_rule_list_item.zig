/// Describes a rule.
pub const TopicRuleListItem = struct {
    /// The date and time the rule was created.
    created_at: ?i64,

    /// The rule ARN.
    rule_arn: ?[]const u8,

    /// Specifies whether the rule is disabled.
    rule_disabled: ?bool,

    /// The name of the rule.
    rule_name: ?[]const u8,

    /// The pattern for the topic names that apply.
    topic_pattern: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .rule_arn = "ruleArn",
        .rule_disabled = "ruleDisabled",
        .rule_name = "ruleName",
        .topic_pattern = "topicPattern",
    };
};
