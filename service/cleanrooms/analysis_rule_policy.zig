const AnalysisRulePolicyV1 = @import("analysis_rule_policy_v1.zig").AnalysisRulePolicyV1;

/// Controls on the query specifications that can be run on configured table.
pub const AnalysisRulePolicy = union(enum) {
    /// Controls on the query specifications that can be run on configured table.
    v_1: ?AnalysisRulePolicyV1,

    pub const json_field_names = .{
        .v_1 = "v1",
    };
};
