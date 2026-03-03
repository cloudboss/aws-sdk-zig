const Cluster = @import("cluster.zig").Cluster;

pub const DeleteClusterResponse = struct {
    /// The full description of the deleted cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
