const AnalysisRule = @import("analysis_rule.zig").AnalysisRule;

/// Contains information about an unused access analyzer.
pub const UnusedAccessConfiguration = struct {
    analysis_rule: ?AnalysisRule,

    /// The specified access age in days for which to generate findings for unused
    /// access. For example, if you specify 90 days, the analyzer will generate
    /// findings for IAM entities within the accounts of the selected organization
    /// for any access that hasn't been used in 90 or more days since the analyzer's
    /// last scan. You can choose a value between 1 and 365 days.
    unused_access_age: ?i32,

    pub const json_field_names = .{
        .analysis_rule = "analysisRule",
        .unused_access_age = "unusedAccessAge",
    };
};
