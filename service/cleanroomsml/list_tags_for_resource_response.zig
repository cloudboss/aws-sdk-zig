const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags that are associated with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
