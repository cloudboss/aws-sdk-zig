/// Metrics for the stream.
pub const ConverseStreamMetrics = struct {
    /// The latency for the streaming request, in milliseconds.
    latency_ms: i64,

    pub const json_field_names = .{
        .latency_ms = "latencyMs",
    };
};
