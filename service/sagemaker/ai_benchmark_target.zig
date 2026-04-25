const AIBenchmarkEndpoint = @import("ai_benchmark_endpoint.zig").AIBenchmarkEndpoint;

/// The target for an AI benchmark job. This is a union type — specify one of
/// the members.
pub const AIBenchmarkTarget = union(enum) {
    /// The SageMaker endpoint to benchmark.
    endpoint: ?AIBenchmarkEndpoint,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
    };
};
