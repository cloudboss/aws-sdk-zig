const HorizontalPodAutoscalerControllerConfigRequest = @import("horizontal_pod_autoscaler_controller_config_request.zig").HorizontalPodAutoscalerControllerConfigRequest;
const PodGcControllerConfigRequest = @import("pod_gc_controller_config_request.zig").PodGcControllerConfigRequest;

/// The configuration for the Kubernetes controller manager on an Amazon EKS
/// cluster.
pub const KubeControllerManagerConfigRequest = struct {
    /// The horizontal pod autoscaler controller configuration.
    horizontal_pod_autoscaler_controller_config: ?HorizontalPodAutoscalerControllerConfigRequest = null,

    /// The pod garbage collection controller configuration.
    pod_gc_controller_config: ?PodGcControllerConfigRequest = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_controller_config = "horizontalPodAutoscalerControllerConfig",
        .pod_gc_controller_config = "podGcControllerConfig",
    };
};
