const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsForResourceResponse = struct {
    /// Adds a tag to a resource.
    resource_tags: ?[]const ResourceTag,

    pub const json_field_names = .{
        .resource_tags = "ResourceTags",
    };
};
