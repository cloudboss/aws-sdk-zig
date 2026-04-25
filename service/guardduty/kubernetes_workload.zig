const KubernetesResourcesTypes = @import("kubernetes_resources_types.zig").KubernetesResourcesTypes;

/// Contains information about Kubernetes workloads involved in a GuardDuty
/// finding, including pods, deployments, and other Kubernetes resources.
pub const KubernetesWorkload = struct {
    /// A list of unique identifiers for the containers that are part of the
    /// Kubernetes workload.
    container_uids: ?[]const []const u8 = null,

    /// The types of Kubernetes resources involved in the workload.
    kubernetes_resources_types: ?KubernetesResourcesTypes = null,

    /// The Kubernetes namespace in which the workload is running, providing logical
    /// isolation within the cluster.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_uids = "ContainerUids",
        .kubernetes_resources_types = "KubernetesResourcesTypes",
        .namespace = "Namespace",
    };
};
