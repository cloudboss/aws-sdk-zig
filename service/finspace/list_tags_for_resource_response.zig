const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of all tags for a resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
