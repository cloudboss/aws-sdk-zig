const EndpointInfo = @import("endpoint_info.zig").EndpointInfo;
const InferenceMetrics = @import("inference_metrics.zig").InferenceMetrics;

/// The performance results from running an Inference Recommender job on an
/// existing endpoint.
pub const EndpointPerformance = struct {
    endpoint_info: EndpointInfo,

    /// The metrics for an existing endpoint.
    metrics: InferenceMetrics,

    pub const json_field_names = .{
        .endpoint_info = "EndpointInfo",
        .metrics = "Metrics",
    };
};
