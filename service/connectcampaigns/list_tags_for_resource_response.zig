const aws = @import("aws");

/// ListTagsForResponse
pub const ListTagsForResourceResponse = struct {
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
