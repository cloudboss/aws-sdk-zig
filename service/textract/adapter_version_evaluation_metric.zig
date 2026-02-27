const EvaluationMetric = @import("evaluation_metric.zig").EvaluationMetric;
const FeatureType = @import("feature_type.zig").FeatureType;

/// Contains information on the metrics used to evalute the peformance of a
/// given adapter version. Includes data for
/// baseline model performance and individual adapter version perfromance.
pub const AdapterVersionEvaluationMetric = struct {
    /// The F1 score, precision, and recall metrics for the baseline model.
    adapter_version: ?EvaluationMetric,

    /// The F1 score, precision, and recall metrics for the baseline model.
    baseline: ?EvaluationMetric,

    /// Indicates the feature type being analyzed by a given adapter version.
    feature_type: ?FeatureType,

    pub const json_field_names = .{
        .adapter_version = "AdapterVersion",
        .baseline = "Baseline",
        .feature_type = "FeatureType",
    };
};
