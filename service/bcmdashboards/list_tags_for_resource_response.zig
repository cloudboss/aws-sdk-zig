const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsForResourceResponse = struct {
    /// The list of tags associated with the specified dashboard resource.
    resource_tags: ?[]const ResourceTag,

    pub const json_field_names = .{
        .resource_tags = "resourceTags",
    };
};
