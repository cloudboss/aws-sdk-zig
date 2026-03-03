const aws = @import("aws");

/// The request for ListTagsForResource API.
pub const ListTagsForResourceResponse = struct {
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
