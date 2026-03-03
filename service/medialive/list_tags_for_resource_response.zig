const aws = @import("aws");

/// Placeholder documentation for ListTagsForResourceResponse
pub const ListTagsForResourceResponse = struct {
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
