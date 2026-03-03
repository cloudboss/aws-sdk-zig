const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsForResourceResponse = struct {
    /// A list of tag key value pairs that are associated with the resource.
    resource_tags: ?[]const ResourceTag = null,

    pub const json_field_names = .{
        .resource_tags = "resourceTags",
    };
};
