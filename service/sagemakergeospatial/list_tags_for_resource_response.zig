const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
