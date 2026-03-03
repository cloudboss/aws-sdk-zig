const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of key-value pairs to associate with the pipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
