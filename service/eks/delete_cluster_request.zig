pub const DeleteClusterRequest = struct {
    /// The name of the cluster to delete.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
