pub const DeleteClusterRequest = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster to delete.
    cluster: []const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
