pub const UntagResourceRequest = struct {
    /// Specifies the EFS resource that you want to remove tags from.
    resource_id: []const u8,

    /// The keys of the key-value tag pairs that you want to remove from the
    /// specified
    /// EFS resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tag_keys = "TagKeys",
    };
};
