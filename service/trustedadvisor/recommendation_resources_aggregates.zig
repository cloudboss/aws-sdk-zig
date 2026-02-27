/// Aggregation of Recommendation Resources
pub const RecommendationResourcesAggregates = struct {
    /// The number of AWS resources that were flagged to have errors according to
    /// the Trusted Advisor check
    error_count: i64,

    /// The number of AWS resources that were flagged to be OK according to the
    /// Trusted Advisor check
    ok_count: i64,

    /// The number of AWS resources that were flagged to have warning according to
    /// the Trusted Advisor check
    warning_count: i64,

    pub const json_field_names = .{
        .error_count = "errorCount",
        .ok_count = "okCount",
        .warning_count = "warningCount",
    };
};
