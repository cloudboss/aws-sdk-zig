const aws = @import("aws");

const ClusterKubernetesTaint = @import("cluster_kubernetes_taint.zig").ClusterKubernetesTaint;

/// Kubernetes configuration that specifies labels and taints to be applied to
/// cluster nodes in an instance group.
pub const ClusterKubernetesConfig = struct {
    /// Key-value pairs of labels to be applied to cluster nodes.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// List of taints to be applied to cluster nodes.
    taints: ?[]const ClusterKubernetesTaint = null,

    pub const json_field_names = .{
        .labels = "Labels",
        .taints = "Taints",
    };
};
