const EdgeMetric = @import("edge_metric.zig").EdgeMetric;

/// Information about a model deployed on an edge device that is registered with
/// SageMaker Edge Manager.
pub const Model = struct {
    /// The timestamp of the last inference that was made.
    latest_inference: ?i64,

    /// The timestamp of the last data sample taken.
    latest_sample_time: ?i64,

    /// Information required for model metrics.
    model_metrics: ?[]const EdgeMetric,

    /// The name of the model.
    model_name: ?[]const u8,

    /// The version of the model.
    model_version: ?[]const u8,

    pub const json_field_names = .{
        .latest_inference = "LatestInference",
        .latest_sample_time = "LatestSampleTime",
        .model_metrics = "ModelMetrics",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};
