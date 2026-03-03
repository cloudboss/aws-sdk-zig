const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags that the `ListTagsForResource` API returned.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
