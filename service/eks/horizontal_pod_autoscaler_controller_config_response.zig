/// The horizontal pod autoscaler controller configuration for the Kubernetes
/// controller manager.
pub const HorizontalPodAutoscalerControllerConfigResponse = struct {
    /// The interval between each sync of the horizontal pod autoscaler.
    horizontal_pod_autoscaler_sync_period: ?[]const u8 = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_sync_period = "horizontalPodAutoscalerSyncPeriod",
    };
};
