/// The metrics for an existing endpoint compared in an Inference Recommender
/// job.
pub const InferenceMetrics = struct {
    /// The expected maximum number of requests per minute for the instance.
    max_invocations: i32,

    /// The expected model latency at maximum invocations per minute for the
    /// instance.
    model_latency: i32,

    pub const json_field_names = .{
        .max_invocations = "MaxInvocations",
        .model_latency = "ModelLatency",
    };
};
