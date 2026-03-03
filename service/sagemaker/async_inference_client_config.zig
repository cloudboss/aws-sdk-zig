/// Configures the behavior of the client used by SageMaker to interact with the
/// model container during asynchronous inference.
pub const AsyncInferenceClientConfig = struct {
    /// The maximum number of concurrent requests sent by the SageMaker client to
    /// the model container. If no value is provided, SageMaker chooses an optimal
    /// value.
    max_concurrent_invocations_per_instance: ?i32 = null,

    pub const json_field_names = .{
        .max_concurrent_invocations_per_instance = "MaxConcurrentInvocationsPerInstance",
    };
};
