const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags used to categorize and track resources.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
