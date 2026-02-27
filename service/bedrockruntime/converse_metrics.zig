/// Metrics for a call to
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html).
pub const ConverseMetrics = struct {
    /// The latency of the call to `Converse`, in milliseconds.
    latency_ms: i64,

    pub const json_field_names = .{
        .latency_ms = "latencyMs",
    };
};
