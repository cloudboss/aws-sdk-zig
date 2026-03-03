const RelevanceMetric = @import("relevance_metric.zig").RelevanceMetric;

/// Metrics that describe the quality of the generated audience.
pub const AudienceQualityMetrics = struct {
    /// The recall score of the generated audience. Recall is the percentage of the
    /// most similar users (by default, the most similar 20%) from a sample of the
    /// training data that are included in the seed audience by the audience
    /// generation job. Values range from 0-1, larger values indicate a better
    /// audience. A recall value approximately equal to the maximum bin size
    /// indicates that the audience model is equivalent to random selection.
    recall_metric: ?f64 = null,

    /// The relevance scores of the generated audience.
    relevance_metrics: []const RelevanceMetric,

    pub const json_field_names = .{
        .recall_metric = "recallMetric",
        .relevance_metrics = "relevanceMetrics",
    };
};
