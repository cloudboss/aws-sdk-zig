const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags that are assigned to the identity pool.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
