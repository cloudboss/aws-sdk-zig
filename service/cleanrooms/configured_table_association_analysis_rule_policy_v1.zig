const ConfiguredTableAssociationAnalysisRuleAggregation = @import("configured_table_association_analysis_rule_aggregation.zig").ConfiguredTableAssociationAnalysisRuleAggregation;
const ConfiguredTableAssociationAnalysisRuleCustom = @import("configured_table_association_analysis_rule_custom.zig").ConfiguredTableAssociationAnalysisRuleCustom;
const ConfiguredTableAssociationAnalysisRuleList = @import("configured_table_association_analysis_rule_list.zig").ConfiguredTableAssociationAnalysisRuleList;

/// Controls on the query specifications that can be run on an associated
/// configured table.
pub const ConfiguredTableAssociationAnalysisRulePolicyV1 = union(enum) {
    /// Analysis rule type that enables only aggregation queries on a configured
    /// table.
    aggregation: ?ConfiguredTableAssociationAnalysisRuleAggregation,
    /// Analysis rule type that enables the table owner to approve custom SQL
    /// queries on their configured tables. It supports differential privacy.
    custom: ?ConfiguredTableAssociationAnalysisRuleCustom,
    /// Analysis rule type that enables only list queries on a configured table.
    list: ?ConfiguredTableAssociationAnalysisRuleList,

    pub const json_field_names = .{
        .aggregation = "aggregation",
        .custom = "custom",
        .list = "list",
    };
};
