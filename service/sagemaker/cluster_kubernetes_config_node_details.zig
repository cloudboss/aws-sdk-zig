const aws = @import("aws");

const ClusterKubernetesTaint = @import("cluster_kubernetes_taint.zig").ClusterKubernetesTaint;

/// Node-specific Kubernetes configuration showing both current and desired
/// state of labels and taints for an individual cluster node.
pub const ClusterKubernetesConfigNodeDetails = struct {
    /// The current labels applied to the cluster node.
    current_labels: ?[]const aws.map.StringMapEntry = null,

    /// The current taints applied to the cluster node.
    current_taints: ?[]const ClusterKubernetesTaint = null,

    /// The desired labels to be applied to the cluster node.
    desired_labels: ?[]const aws.map.StringMapEntry = null,

    /// The desired taints to be applied to the cluster node.
    desired_taints: ?[]const ClusterKubernetesTaint = null,

    pub const json_field_names = .{
        .current_labels = "CurrentLabels",
        .current_taints = "CurrentTaints",
        .desired_labels = "DesiredLabels",
        .desired_taints = "DesiredTaints",
    };
};
