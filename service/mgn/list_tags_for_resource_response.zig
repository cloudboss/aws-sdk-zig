const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// List tags for resource response.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
