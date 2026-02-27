const SummaryRuleOption = @import("summary_rule_option.zig").SummaryRuleOption;

/// A complex type that specifies which Suricata rule metadata fields to use
/// when displaying threat information. Contains:
///
/// * `RuleOptions` - The Suricata rule options fields to extract and display
///
/// These settings affect how threat information appears in both the console and
/// API responses. Summaries are available for rule groups you manage and for
/// active threat defense Amazon Web Services managed rule groups.
pub const SummaryConfiguration = struct {
    /// Specifies the selected rule options returned by DescribeRuleGroupSummary.
    rule_options: ?[]const SummaryRuleOption,

    pub const json_field_names = .{
        .rule_options = "RuleOptions",
    };
};
