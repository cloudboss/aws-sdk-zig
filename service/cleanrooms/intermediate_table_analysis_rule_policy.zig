const IntermediateTableAnalysisRulePolicyV1 = @import("intermediate_table_analysis_rule_policy_v1.zig").IntermediateTableAnalysisRulePolicyV1;

/// Contains the policy for an intermediate table analysis rule.
pub const IntermediateTableAnalysisRulePolicy = union(enum) {
    /// The version 1 policy for the analysis rule.
    v_1: ?IntermediateTableAnalysisRulePolicyV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
