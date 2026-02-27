const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;

/// Settings for a model called with InvokeAgent.
pub const BedrockModelConfigurations = struct {
    /// The performance configuration for the model.
    performance_config: ?PerformanceConfiguration,

    pub const json_field_names = .{
        .performance_config = "performanceConfig",
    };
};
