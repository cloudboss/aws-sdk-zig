pub const UntagResourceRequest = struct {
    /// The name of the DAX resource from which the tags should be
    /// removed.
    resource_name: []const u8,

    /// A list of tag keys. If the DAX cluster has any tags with these keys,
    /// then the tags are removed from the cluster.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_name = "ResourceName",
        .tag_keys = "TagKeys",
    };
};
