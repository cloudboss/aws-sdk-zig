/// Latency metrics for the invocation.
pub const HarnessStreamMetrics = struct {
    /// The end-to-end latency of the invocation in milliseconds.
    latency_ms: i64,

    pub const json_field_names = .{
        .latency_ms = "latencyMs",
    };
};
