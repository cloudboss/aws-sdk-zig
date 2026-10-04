const KubeApiServerVersionConfig = @import("kube_api_server_version_config.zig").KubeApiServerVersionConfig;
const KubeControllerManagerVersionConfig = @import("kube_controller_manager_version_config.zig").KubeControllerManagerVersionConfig;
const KubeSchedulerVersionConfig = @import("kube_scheduler_version_config.zig").KubeSchedulerVersionConfig;

/// The control plane component configuration defaults and constraints.
pub const ControlPlaneConfigInfo = struct {
    /// The Kubernetes API server configuration defaults and constraints.
    kube_api_server_config: ?KubeApiServerVersionConfig = null,

    /// The Kubernetes controller manager configuration defaults and constraints.
    kube_controller_manager_config: ?KubeControllerManagerVersionConfig = null,

    /// The Kubernetes scheduler configuration defaults and constraints.
    kube_scheduler_config: ?KubeSchedulerVersionConfig = null,

    pub const json_field_names = .{
        .kube_api_server_config = "kubeApiServerConfig",
        .kube_controller_manager_config = "kubeControllerManagerConfig",
        .kube_scheduler_config = "kubeSchedulerConfig",
    };
};
