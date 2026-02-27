const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The key-value pairs for the tags associated with the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
