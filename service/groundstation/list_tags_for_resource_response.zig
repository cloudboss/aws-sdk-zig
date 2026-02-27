const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Tags assigned to a resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
