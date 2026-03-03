const Cluster = @import("cluster.zig").Cluster;

pub const DescribeClusterResponse = struct {
    /// The full description of your specified cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};
