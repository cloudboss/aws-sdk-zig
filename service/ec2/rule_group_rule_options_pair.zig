const RuleOption = @import("rule_option.zig").RuleOption;

/// Describes the rule options for a stateful rule group.
pub const RuleGroupRuleOptionsPair = struct {
    /// The ARN of the rule group.
    rule_group_arn: ?[]const u8,

    /// The rule options.
    rule_options: ?[]const RuleOption,
};
