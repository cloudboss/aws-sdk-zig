const EksLabelSelector = @import("eks_label_selector.zig").EksLabelSelector;

/// Defines an Amazon EKS cluster and its namespaces as an input source for
/// resource discovery.
pub const EksSource = struct {
    cluster_arn: []const u8,

    /// Filters discovery to the Kubernetes objects whose labels match the selector.
    /// When omitted, all supported objects in the specified namespaces are
    /// discovered.
    label_selector: ?EksLabelSelector = null,

    /// The list of Kubernetes namespaces within the EKS cluster.
    namespaces: []const []const u8,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .label_selector = "labelSelector",
        .namespaces = "namespaces",
    };
};
