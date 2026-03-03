const FindMatchesMetrics = @import("find_matches_metrics.zig").FindMatchesMetrics;
const TransformType = @import("transform_type.zig").TransformType;

/// Evaluation metrics provide an estimate of the quality of your machine
/// learning transform.
pub const EvaluationMetrics = struct {
    /// The evaluation metrics for the find matches algorithm.
    find_matches_metrics: ?FindMatchesMetrics = null,

    /// The type of machine learning transform.
    transform_type: TransformType,

    pub const json_field_names = .{
        .find_matches_metrics = "FindMatchesMetrics",
        .transform_type = "TransformType",
    };
};
