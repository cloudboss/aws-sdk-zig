const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags of the requested resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
