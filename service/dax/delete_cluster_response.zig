const Cluster = @import("cluster.zig").Cluster;

pub const DeleteClusterResponse = struct {
    /// A description of the DAX cluster that is being deleted.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};
