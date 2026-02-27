const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterResponse = struct {
    /// A description of the DAX cluster, after it has been modified.
    cluster: ?Cluster,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};
