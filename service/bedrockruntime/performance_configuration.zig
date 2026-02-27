const PerformanceConfigLatency = @import("performance_config_latency.zig").PerformanceConfigLatency;

/// Performance settings for a model.
pub const PerformanceConfiguration = struct {
    /// To use a latency-optimized version of the model, set to `optimized`.
    latency: PerformanceConfigLatency = "standard",

    pub const json_field_names = .{
        .latency = "latency",
    };
};
