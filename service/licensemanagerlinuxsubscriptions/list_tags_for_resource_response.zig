const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The metadata tags for the requested resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
