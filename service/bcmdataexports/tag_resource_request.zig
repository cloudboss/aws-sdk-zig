const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    /// The tags to associate with the resource. Each tag consists of a key and a
    /// value, and each
    /// key must be unique for the resource.
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tags = "ResourceTags",
    };
};
