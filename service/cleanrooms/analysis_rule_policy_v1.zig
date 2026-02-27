const AnalysisRuleAggregation = @import("analysis_rule_aggregation.zig").AnalysisRuleAggregation;
const AnalysisRuleCustom = @import("analysis_rule_custom.zig").AnalysisRuleCustom;
const AnalysisRuleIdMappingTable = @import("analysis_rule_id_mapping_table.zig").AnalysisRuleIdMappingTable;
const AnalysisRuleList = @import("analysis_rule_list.zig").AnalysisRuleList;

/// Controls on the query specifications that can be run on configured table.
pub const AnalysisRulePolicyV1 = union(enum) {
    /// Analysis rule type that enables only aggregation queries on a configured
    /// table.
    aggregation: ?AnalysisRuleAggregation,
    /// Analysis rule type that enables custom SQL queries on a configured table.
    custom: ?AnalysisRuleCustom,
    /// The ID mapping table.
    id_mapping_table: ?AnalysisRuleIdMappingTable,
    /// Analysis rule type that enables only list queries on a configured table.
    list: ?AnalysisRuleList,

    pub const json_field_names = .{
        .aggregation = "aggregation",
        .custom = "custom",
        .id_mapping_table = "idMappingTable",
        .list = "list",
    };
};
