const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterResponse = struct {
    /// A description of the DAX cluster that you have created.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};
