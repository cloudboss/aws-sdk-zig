const Cluster = @import("cluster.zig").Cluster;

pub const DeleteClusterResponse = struct {
    /// A description of the DAX cluster that is being deleted.
    cluster: ?Cluster,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};
