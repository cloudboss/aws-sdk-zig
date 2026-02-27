const FlatInvocations = @import("flat_invocations.zig").FlatInvocations;
const ModelLatencyThreshold = @import("model_latency_threshold.zig").ModelLatencyThreshold;

/// Specifies conditions for stopping a job. When a job reaches a stopping
/// condition limit, SageMaker ends the job.
pub const RecommendationJobStoppingConditions = struct {
    /// Stops a load test when the number of invocations (TPS) peaks and flattens,
    /// which means that the instance has reached capacity. The default value is
    /// `Stop`. If you want the load test to continue after invocations have
    /// flattened, set the value to `Continue`.
    flat_invocations: ?FlatInvocations,

    /// The maximum number of requests per minute expected for the endpoint.
    max_invocations: ?i32,

    /// The interval of time taken by a model to respond as viewed from SageMaker.
    /// The interval includes the local communication time taken to send the request
    /// and to fetch the response from the container of a model and the time taken
    /// to complete the inference in the container.
    model_latency_thresholds: ?[]const ModelLatencyThreshold,

    pub const json_field_names = .{
        .flat_invocations = "FlatInvocations",
        .max_invocations = "MaxInvocations",
        .model_latency_thresholds = "ModelLatencyThresholds",
    };
};
