/// Describes a rule.
pub const TopicRuleListItem = struct {
    /// The date and time the rule was created.
    created_at: ?i64 = null,

    /// The rule ARN.
    rule_arn: ?[]const u8 = null,

    /// Specifies whether the rule is disabled.
    rule_disabled: ?bool = null,

    /// The name of the rule.
    rule_name: ?[]const u8 = null,

    /// The pattern for the topic names that apply.
    topic_pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .rule_arn = "ruleArn",
        .rule_disabled = "ruleDisabled",
        .rule_name = "ruleName",
        .topic_pattern = "topicPattern",
    };
};
