/// The information about the Amazon EKS cluster.
pub const EksInfo = struct {
    /// The namespaces of the Amazon EKS cluster.
    namespace: ?[]const u8 = null,

    /// The nodeLabel of the nodes where the resources of this virtual cluster can
    /// get scheduled. It requires relevant scaling and policy engine addons.
    node_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace = "namespace",
        .node_label = "nodeLabel",
    };
};
