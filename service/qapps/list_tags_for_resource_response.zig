const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags that are assigned to the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
