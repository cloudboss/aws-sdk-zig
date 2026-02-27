const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags for the specified elastic cluster resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
