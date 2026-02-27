/// Information about the priorities for the rules for a listener.
pub const RulePriorityPair = struct {
    /// The rule priority.
    priority: ?i32,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: ?[]const u8,
};
