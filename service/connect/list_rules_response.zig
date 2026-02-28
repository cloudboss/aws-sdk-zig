const RuleSummary = @import("rule_summary.zig").RuleSummary;

pub const ListRulesResponse = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8,

    /// Summary information about a rule.
    rule_summary_list: []const RuleSummary,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rule_summary_list = "RuleSummaryList",
    };
};
