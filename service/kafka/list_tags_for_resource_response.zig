const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The key-value pair for the resource tag.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
