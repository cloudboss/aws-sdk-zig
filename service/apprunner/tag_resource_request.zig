const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to update tags
    /// for.
    ///
    /// It must be the ARN of an App Runner resource.
    resource_arn: []const u8,

    /// A list of tag key-value pairs to add or update. If a key is new to the
    /// resource, the tag is added with the provided value. If a key is already
    /// associated with the resource, the value of the tag is updated.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
