const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A map of key-value pairs, where each pair represents a tag present on the
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
