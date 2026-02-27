const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags added to a resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
