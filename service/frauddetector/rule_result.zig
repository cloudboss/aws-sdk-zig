/// The rule results.
pub const RuleResult = struct {
    /// The outcomes of the matched rule, based on the rule execution mode.
    outcomes: ?[]const []const u8,

    /// The rule ID that was matched, based on the rule execution mode.
    rule_id: ?[]const u8,

    pub const json_field_names = .{
        .outcomes = "outcomes",
        .rule_id = "ruleId",
    };
};
