/// The horizontal pod autoscaler controller configuration for the Kubernetes
/// controller manager.
pub const HorizontalPodAutoscalerControllerConfigRequest = struct {
    /// The interval between each sync of the horizontal pod autoscaler. Valid
    /// values are single-unit durations such as `15s` or `1m`.
    horizontal_pod_autoscaler_sync_period: ?[]const u8 = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_sync_period = "horizontalPodAutoscalerSyncPeriod",
    };
};
