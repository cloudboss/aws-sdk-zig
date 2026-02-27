/// The metric for a scaling policy.
pub const ScalingPolicyMetric = struct {
    /// The number of invocations sent to a model, normalized by `InstanceCount` in
    /// each ProductionVariant. `1/numberOfInstances` is sent as the value on each
    /// request, where `numberOfInstances` is the number of active instances for the
    /// ProductionVariant behind the endpoint at the time of the request.
    invocations_per_instance: ?i32,

    /// The interval of time taken by a model to respond as viewed from SageMaker.
    /// This interval includes the local communication times taken to send the
    /// request and to fetch the response from the container of a model and the time
    /// taken to complete the inference in the container.
    model_latency: ?i32,

    pub const json_field_names = .{
        .invocations_per_instance = "InvocationsPerInstance",
        .model_latency = "ModelLatency",
    };
};
