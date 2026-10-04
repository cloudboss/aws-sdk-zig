const HorizontalPodAutoscalerControllerConfigResponse = @import("horizontal_pod_autoscaler_controller_config_response.zig").HorizontalPodAutoscalerControllerConfigResponse;
const PodGcControllerConfigResponse = @import("pod_gc_controller_config_response.zig").PodGcControllerConfigResponse;

/// The Kubernetes controller manager configuration for an Amazon EKS cluster.
pub const KubeControllerManagerConfigResponse = struct {
    /// The horizontal pod autoscaler controller configuration.
    horizontal_pod_autoscaler_controller_config: ?HorizontalPodAutoscalerControllerConfigResponse = null,

    /// The pod garbage collection controller configuration.
    pod_gc_controller_config: ?PodGcControllerConfigResponse = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_controller_config = "horizontalPodAutoscalerControllerConfig",
        .pod_gc_controller_config = "podGcControllerConfig",
    };
};
