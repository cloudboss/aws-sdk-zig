/// The metadata of a network function.
///
/// A network instance is a single network created in Amazon Web Services TNB
/// that can be deployed and on which life-cycle operations (like terminate,
/// update, and delete) can be performed.
pub const GetSolVnfcResourceInfoMetadata = struct {
    /// Information about the cluster.
    cluster: ?[]const u8,

    /// Information about the helm chart.
    helm_chart: ?[]const u8,

    /// Information about the node group.
    node_group: ?[]const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
        .helm_chart = "helmChart",
        .node_group = "nodeGroup",
    };
};
