const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags, if any, that are associated with your resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
