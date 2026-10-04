const IntermediateTableAnalysisRuleCustom = @import("intermediate_table_analysis_rule_custom.zig").IntermediateTableAnalysisRuleCustom;

/// Contains the version 1 policy for an intermediate table analysis rule.
pub const IntermediateTableAnalysisRulePolicyV1 = union(enum) {
    /// The custom analysis rule policy.
    custom: ?IntermediateTableAnalysisRuleCustom,

    pub const json_field_names = .{
        .custom = "custom",
    };
};
