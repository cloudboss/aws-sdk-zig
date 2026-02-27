const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags on the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
