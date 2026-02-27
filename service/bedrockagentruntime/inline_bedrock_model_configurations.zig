const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;

/// Settings for a model called with InvokeInlineAgent.
pub const InlineBedrockModelConfigurations = struct {
    /// The latency configuration for the model.
    performance_config: ?PerformanceConfiguration,

    pub const json_field_names = .{
        .performance_config = "performanceConfig",
    };
};
