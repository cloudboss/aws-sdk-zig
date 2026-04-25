const HarnessStreamMetrics = @import("harness_stream_metrics.zig").HarnessStreamMetrics;
const HarnessTokenUsage = @import("harness_token_usage.zig").HarnessTokenUsage;

/// Token usage and latency metrics for the invocation.
pub const HarnessMetadataEvent = struct {
    /// Latency metrics.
    metrics: HarnessStreamMetrics,

    /// Token usage counts.
    usage: HarnessTokenUsage,

    pub const json_field_names = .{
        .metrics = "metrics",
        .usage = "usage",
    };
};
