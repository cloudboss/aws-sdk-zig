const RuleSummary = @import("rule_summary.zig").RuleSummary;

pub const ListRulesResponse = struct {
    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the retention rules.
    rules: ?[]const RuleSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rules = "Rules",
    };
};
