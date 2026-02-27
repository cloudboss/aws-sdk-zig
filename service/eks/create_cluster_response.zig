const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterResponse = struct {
    /// The full description of your new cluster.
    cluster: ?Cluster,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
