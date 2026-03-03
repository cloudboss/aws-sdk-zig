const EndpointOutputConfiguration = @import("endpoint_output_configuration.zig").EndpointOutputConfiguration;
const RecommendationMetrics = @import("recommendation_metrics.zig").RecommendationMetrics;
const ModelConfiguration = @import("model_configuration.zig").ModelConfiguration;

/// A list of recommendations made by Amazon SageMaker Inference Recommender.
pub const InferenceRecommendation = struct {
    /// Defines the endpoint configuration parameters.
    endpoint_configuration: EndpointOutputConfiguration,

    /// A timestamp that shows when the benchmark completed.
    invocation_end_time: ?i64 = null,

    /// A timestamp that shows when the benchmark started.
    invocation_start_time: ?i64 = null,

    /// The metrics used to decide what recommendation to make.
    metrics: ?RecommendationMetrics = null,

    /// Defines the model configuration.
    model_configuration: ModelConfiguration,

    /// The recommendation ID which uniquely identifies each recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_configuration = "EndpointConfiguration",
        .invocation_end_time = "InvocationEndTime",
        .invocation_start_time = "InvocationStartTime",
        .metrics = "Metrics",
        .model_configuration = "ModelConfiguration",
        .recommendation_id = "RecommendationId",
    };
};
