const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tag key value pairs for a specified Amazon Resource Name (ARN).
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
