const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceRequest = struct {
    /// The unique identifier for the resource.
    resource_arn: []const u8,

    /// The tags associated with the resource.
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .resource_tags = "ResourceTags",
    };
};
