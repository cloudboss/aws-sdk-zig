pub const DescribeClusterRequest = struct {
    /// The name of your cluster.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
