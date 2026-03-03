const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags. Each tag consists of a tag key and a tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
