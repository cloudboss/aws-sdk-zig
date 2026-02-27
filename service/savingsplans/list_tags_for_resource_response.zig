const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Information about the tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
