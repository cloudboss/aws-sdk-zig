const InternalAccessAnalysisRuleCriteria = @import("internal_access_analysis_rule_criteria.zig").InternalAccessAnalysisRuleCriteria;

/// Contains information about analysis rules for the internal access analyzer.
/// Analysis rules determine which entities will generate findings based on the
/// criteria you define when you create the rule.
pub const InternalAccessAnalysisRule = struct {
    /// A list of rules for the internal access analyzer containing criteria to
    /// include in analysis. Only resources that meet the rule criteria will
    /// generate findings.
    inclusions: ?[]const InternalAccessAnalysisRuleCriteria = null,

    pub const json_field_names = .{
        .inclusions = "inclusions",
    };
};
