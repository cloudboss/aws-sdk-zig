const RuleSummary = @import("rule_summary.zig").RuleSummary;

/// A complex type containing summaries of security protections provided by a
/// rule group.
///
/// Network Firewall extracts this information from selected fields in the rule
/// group's Suricata rules, based on your SummaryConfiguration settings.
pub const Summary = struct {
    /// An array of RuleSummary objects containing individual rule details that had
    /// been configured by the rulegroup's SummaryConfiguration.
    rule_summaries: ?[]const RuleSummary,

    pub const json_field_names = .{
        .rule_summaries = "RuleSummaries",
    };
};
