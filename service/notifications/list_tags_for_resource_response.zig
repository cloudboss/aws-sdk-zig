const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags for the specified ARN.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
