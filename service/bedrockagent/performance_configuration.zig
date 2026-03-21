const PerformanceConfigLatency = @import("performance_config_latency.zig").PerformanceConfigLatency;

/// The performance-related configuration options for the knowledge base
/// retrieval and generation process.
pub const PerformanceConfiguration = struct {
    /// The latency optimization setting.
    latency: PerformanceConfigLatency = .standard,

    pub const json_field_names = .{
        .latency = "latency",
    };
};
