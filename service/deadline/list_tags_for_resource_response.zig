const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Each tag consists of a tag key and a tag value. Tag keys and values are both
    /// required, but tag values can be empty strings.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
