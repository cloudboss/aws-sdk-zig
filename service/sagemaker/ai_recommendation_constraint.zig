const AIRecommendationMetric = @import("ai_recommendation_metric.zig").AIRecommendationMetric;

/// A performance constraint for an AI recommendation job.
pub const AIRecommendationConstraint = struct {
    /// The performance metric. Valid values are `ttft-ms` (time to first token in
    /// milliseconds), `throughput`, and `cost`.
    metric: AIRecommendationMetric,

    pub const json_field_names = .{
        .metric = "Metric",
    };
};
