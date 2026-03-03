const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterResponse = struct {
    /// Details about the cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
