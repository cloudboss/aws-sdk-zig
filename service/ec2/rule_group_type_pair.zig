/// Describes the type of a stateful rule group.
pub const RuleGroupTypePair = struct {
    /// The ARN of the rule group.
    rule_group_arn: ?[]const u8 = null,

    /// The rule group type. The possible values are `Domain List` and `Suricata`.
    rule_group_type: ?[]const u8 = null,
};
