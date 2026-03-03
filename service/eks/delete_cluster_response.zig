const Cluster = @import("cluster.zig").Cluster;

pub const DeleteClusterResponse = struct {
    /// The full description of the cluster to delete.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
