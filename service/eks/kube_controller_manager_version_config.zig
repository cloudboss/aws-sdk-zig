const HorizontalPodAutoscalerControllerVersionConfig = @import("horizontal_pod_autoscaler_controller_version_config.zig").HorizontalPodAutoscalerControllerVersionConfig;
const PodGcControllerVersionConfig = @import("pod_gc_controller_version_config.zig").PodGcControllerVersionConfig;

/// The Kubernetes controller manager version-specific configuration defaults
/// and constraints.
pub const KubeControllerManagerVersionConfig = struct {
    /// The horizontal pod autoscaler controller configuration with default value
    /// and constraints.
    horizontal_pod_autoscaler_controller_config: ?HorizontalPodAutoscalerControllerVersionConfig = null,

    /// The pod garbage collection controller configuration with default value and
    /// constraints.
    pod_gc_controller_config: ?PodGcControllerVersionConfig = null,

    pub const json_field_names = .{
        .horizontal_pod_autoscaler_controller_config = "horizontalPodAutoscalerControllerConfig",
        .pod_gc_controller_config = "podGcControllerConfig",
    };
};
