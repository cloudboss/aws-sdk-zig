/// Placeholder documentation for DeleteNodeRequest
pub const DeleteNodeRequest = struct {
    /// The ID of the cluster
    cluster_id: []const u8,

    /// The ID of the node.
    node_id: []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .node_id = "NodeId",
    };
};
