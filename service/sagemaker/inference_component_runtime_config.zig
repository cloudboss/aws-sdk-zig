/// Runtime settings for a model that is deployed with an inference component.
pub const InferenceComponentRuntimeConfig = struct {
    /// The number of runtime copies of the model container to deploy with the
    /// inference component. Each copy can serve inference requests.
    copy_count: i32,

    pub const json_field_names = .{
        .copy_count = "CopyCount",
    };
};
