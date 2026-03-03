const aws = @import("aws");

const ClusterKubernetesTaint = @import("cluster_kubernetes_taint.zig").ClusterKubernetesTaint;

/// Detailed Kubernetes configuration showing both the current and desired state
/// of labels and taints for cluster nodes.
pub const ClusterKubernetesConfigDetails = struct {
    /// The current labels applied to cluster nodes of an instance group.
    current_labels: ?[]const aws.map.StringMapEntry = null,

    /// The current taints applied to cluster nodes of an instance group.
    current_taints: ?[]const ClusterKubernetesTaint = null,

    /// The desired labels to be applied to cluster nodes of an instance group.
    desired_labels: ?[]const aws.map.StringMapEntry = null,

    /// The desired taints to be applied to cluster nodes of an instance group.
    desired_taints: ?[]const ClusterKubernetesTaint = null,

    pub const json_field_names = .{
        .current_labels = "CurrentLabels",
        .current_taints = "CurrentTaints",
        .desired_labels = "DesiredLabels",
        .desired_taints = "DesiredTaints",
    };
};
