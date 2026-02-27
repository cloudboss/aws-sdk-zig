pub const DeleteClusterRequest = struct {
    /// The name of the cluster to be deleted.
    cluster_name: []const u8,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
    };
};
