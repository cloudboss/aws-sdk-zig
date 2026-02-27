const EndpointOutputConfiguration = @import("endpoint_output_configuration.zig").EndpointOutputConfiguration;
const InferenceMetrics = @import("inference_metrics.zig").InferenceMetrics;
const RecommendationMetrics = @import("recommendation_metrics.zig").RecommendationMetrics;
const ModelConfiguration = @import("model_configuration.zig").ModelConfiguration;

/// The details for a specific benchmark from an Inference Recommender job.
pub const RecommendationJobInferenceBenchmark = struct {
    endpoint_configuration: ?EndpointOutputConfiguration,

    endpoint_metrics: ?InferenceMetrics,

    /// The reason why a benchmark failed.
    failure_reason: ?[]const u8,

    /// A timestamp that shows when the benchmark completed.
    invocation_end_time: ?i64,

    /// A timestamp that shows when the benchmark started.
    invocation_start_time: ?i64,

    metrics: ?RecommendationMetrics,

    model_configuration: ModelConfiguration,

    pub const json_field_names = .{
        .endpoint_configuration = "EndpointConfiguration",
        .endpoint_metrics = "EndpointMetrics",
        .failure_reason = "FailureReason",
        .invocation_end_time = "InvocationEndTime",
        .invocation_start_time = "InvocationStartTime",
        .metrics = "Metrics",
        .model_configuration = "ModelConfiguration",
    };
};
