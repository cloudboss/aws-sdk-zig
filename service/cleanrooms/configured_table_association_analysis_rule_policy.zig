const ConfiguredTableAssociationAnalysisRulePolicyV1 = @import("configured_table_association_analysis_rule_policy_v1.zig").ConfiguredTableAssociationAnalysisRulePolicyV1;

/// Controls on the query specifications that can be run on an associated
/// configured table.
pub const ConfiguredTableAssociationAnalysisRulePolicy = union(enum) {
    /// The policy for the configured table association analysis rule.
    v_1: ?ConfiguredTableAssociationAnalysisRulePolicyV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
