const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// A list of tag key value pairs that are associated with the resource.
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_tags = "resourceTags",
    };
};
