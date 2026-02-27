/// The summary of rightsizing recommendations, including de-duped savings from
/// all types of recommendations.
pub const RecommendationSummary = struct {
    /// The estimated total savings resulting from modifications, on a monthly
    /// basis.
    estimated_monthly_savings: ?f64,

    /// The grouping of recommendations.
    group: ?[]const u8,

    /// The total number of instance recommendations.
    recommendation_count: ?i32,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .group = "group",
        .recommendation_count = "recommendationCount",
    };
};
