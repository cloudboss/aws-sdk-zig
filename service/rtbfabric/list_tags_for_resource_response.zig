const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A map of the key-value pairs for the tag or tags assigned to the specified
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
