const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;

/// The performance configuration for a model called with InvokeFlow.
pub const ModelPerformanceConfiguration = struct {
    /// The latency configuration for the model.
    performance_config: ?PerformanceConfiguration,

    pub const json_field_names = .{
        .performance_config = "performanceConfig",
    };
};
