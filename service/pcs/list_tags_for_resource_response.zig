const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// 1 or more tags added to the resource. Each tag consists of a tag key and tag
    /// value. The tag value is optional and can be an empty string.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
