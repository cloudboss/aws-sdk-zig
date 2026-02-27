const RuleAction = @import("rule_action.zig").RuleAction;
const RuleMatch = @import("rule_match.zig").RuleMatch;

/// Describes a rule update.
pub const RuleUpdate = struct {
    /// The rule action.
    action: ?RuleAction,

    /// The rule match.
    match: ?RuleMatch,

    /// The rule priority. A listener can't have multiple rules with the same
    /// priority.
    priority: ?i32,

    /// The ID or ARN of the rule.
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .priority = "priority",
        .rule_identifier = "ruleIdentifier",
    };
};
