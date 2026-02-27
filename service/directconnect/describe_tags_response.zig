const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const DescribeTagsResponse = struct {
    /// Information about the tags.
    resource_tags: ?[]const ResourceTag,

    pub const json_field_names = .{
        .resource_tags = "resourceTags",
    };
};
