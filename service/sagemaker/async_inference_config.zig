const AsyncInferenceClientConfig = @import("async_inference_client_config.zig").AsyncInferenceClientConfig;
const AsyncInferenceOutputConfig = @import("async_inference_output_config.zig").AsyncInferenceOutputConfig;

/// Specifies configuration for how an endpoint performs asynchronous inference.
pub const AsyncInferenceConfig = struct {
    /// Configures the behavior of the client used by SageMaker to interact with the
    /// model container during asynchronous inference.
    client_config: ?AsyncInferenceClientConfig,

    /// Specifies the configuration for asynchronous inference invocation outputs.
    output_config: AsyncInferenceOutputConfig,

    pub const json_field_names = .{
        .client_config = "ClientConfig",
        .output_config = "OutputConfig",
    };
};
