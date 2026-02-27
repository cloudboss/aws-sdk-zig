const PerformanceConfigLatency = @import("performance_config_latency.zig").PerformanceConfigLatency;

/// Contains performance settings for a model.
pub const PerformanceConfiguration = struct {
    /// Specifies whether to use the latency-optimized or standard version of a
    /// model or inference profile.
    latency: ?PerformanceConfigLatency,

    pub const json_field_names = .{
        .latency = "latency",
    };
};
