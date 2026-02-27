const ConfiguredTableAnalysisRulePolicyV1 = @import("configured_table_analysis_rule_policy_v1.zig").ConfiguredTableAnalysisRulePolicyV1;

/// Controls on the query specifications that can be run on a configured table.
pub const ConfiguredTableAnalysisRulePolicy = union(enum) {
    /// Controls on the query specifications that can be run on a configured table.
    v_1: ?ConfiguredTableAnalysisRulePolicyV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
