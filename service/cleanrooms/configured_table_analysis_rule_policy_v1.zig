const AnalysisRuleAggregation = @import("analysis_rule_aggregation.zig").AnalysisRuleAggregation;
const AnalysisRuleCustom = @import("analysis_rule_custom.zig").AnalysisRuleCustom;
const AnalysisRuleList = @import("analysis_rule_list.zig").AnalysisRuleList;

/// Controls on the query specifications that can be run on a configured table.
pub const ConfiguredTableAnalysisRulePolicyV1 = union(enum) {
    /// Analysis rule type that enables only aggregation queries on a configured
    /// table.
    aggregation: ?AnalysisRuleAggregation,
    custom: ?AnalysisRuleCustom,
    /// Analysis rule type that enables only list queries on a configured table.
    list: ?AnalysisRuleList,

    pub const json_field_names = .{
        .aggregation = "aggregation",
        .custom = "custom",
        .list = "list",
    };
};
