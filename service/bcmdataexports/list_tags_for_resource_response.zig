const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsForResourceResponse = struct {
    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// An optional list of tags to associate with the specified export. Each tag
    /// consists of a
    /// key and a value, and each key must be unique for the resource.
    resource_tags: ?[]const ResourceTag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_tags = "ResourceTags",
    };
};
