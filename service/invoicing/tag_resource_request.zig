const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the tags.
    resource_arn: []const u8,

    /// Adds a tag to a resource.
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tags = "ResourceTags",
    };
};
