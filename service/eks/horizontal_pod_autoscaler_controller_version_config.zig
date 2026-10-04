const DurationParameterConfig = @import("duration_parameter_config.zig").DurationParameterConfig;

/// The horizontal pod autoscaler controller version configuration.
pub const HorizontalPodAutoscalerControllerVersionConfig = struct {
    /// The HPA sync period configuration with default value and constraints.
    horizontal_pod_autoscaler_sync_period: ?DurationParameterConfig = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_sync_period = "horizontalPodAutoscalerSyncPeriod",
    };
};
