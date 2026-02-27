const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with the resource.
    resource_tags: ?[]const ResourceTag,

    pub const json_field_names = .{
        .resource_tags = "ResourceTags",
    };
};
