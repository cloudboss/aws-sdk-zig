const AnalysisRuleCriteria = @import("analysis_rule_criteria.zig").AnalysisRuleCriteria;

/// Contains information about analysis rules for the analyzer. Analysis rules
/// determine which entities will generate findings based on the criteria you
/// define when you create the rule.
pub const AnalysisRule = struct {
    /// A list of rules for the analyzer containing criteria to exclude from
    /// analysis. Entities that meet the rule criteria will not generate findings.
    exclusions: ?[]const AnalysisRuleCriteria,

    pub const json_field_names = .{
        .exclusions = "exclusions",
    };
};
