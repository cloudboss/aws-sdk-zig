const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
