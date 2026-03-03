/// Details about a rule to exclude from a rule group.
pub const WafExcludedRule = struct {
    /// The unique identifier for the rule to exclude from the rule group.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_id = "RuleId",
    };
};
