const AIBenchmarkInferenceComponent = @import("ai_benchmark_inference_component.zig").AIBenchmarkInferenceComponent;

/// The SageMaker endpoint configuration for benchmarking.
pub const AIBenchmarkEndpoint = struct {
    /// The name or Amazon Resource Name (ARN) of the SageMaker endpoint to
    /// benchmark.
    identifier: []const u8,

    /// The list of inference components to benchmark on the endpoint.
    inference_components: ?[]const AIBenchmarkInferenceComponent = null,

    /// The hostname of the specific container to target within a multi-container
    /// endpoint.
    target_container_hostname: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .inference_components = "InferenceComponents",
        .target_container_hostname = "TargetContainerHostname",
    };
};
