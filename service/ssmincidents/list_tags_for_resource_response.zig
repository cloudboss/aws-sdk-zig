const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags for the response plan or incident.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
