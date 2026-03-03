const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A map of tags that are associated with the resource, where each tag consists
    /// of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
