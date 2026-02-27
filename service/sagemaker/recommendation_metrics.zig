/// The metrics of recommendations.
pub const RecommendationMetrics = struct {
    /// Defines the cost per hour for the instance.
    cost_per_hour: ?f32,

    /// Defines the cost per inference for the instance .
    cost_per_inference: ?f32,

    /// The expected CPU utilization at maximum invocations per minute for the
    /// instance.
    ///
    /// `NaN` indicates that the value is not available.
    cpu_utilization: ?f32,

    /// The expected maximum number of requests per minute for the instance.
    max_invocations: ?i32,

    /// The expected memory utilization at maximum invocations per minute for the
    /// instance.
    ///
    /// `NaN` indicates that the value is not available.
    memory_utilization: ?f32,

    /// The expected model latency at maximum invocation per minute for the
    /// instance.
    model_latency: ?i32,

    /// The time it takes to launch new compute resources for a serverless endpoint.
    /// The time can vary depending on the model size, how long it takes to download
    /// the model, and the start-up time of the container.
    ///
    /// `NaN` indicates that the value is not available.
    model_setup_time: ?i32,

    pub const json_field_names = .{
        .cost_per_hour = "CostPerHour",
        .cost_per_inference = "CostPerInference",
        .cpu_utilization = "CpuUtilization",
        .max_invocations = "MaxInvocations",
        .memory_utilization = "MemoryUtilization",
        .model_latency = "ModelLatency",
        .model_setup_time = "ModelSetupTime",
    };
};
