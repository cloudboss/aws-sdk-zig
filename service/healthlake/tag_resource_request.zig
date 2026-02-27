const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that grants access to the data store tags are
    /// being added to.
    resource_arn: []const u8,

    /// The user-specified key and value pair tags being added to a data store.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
