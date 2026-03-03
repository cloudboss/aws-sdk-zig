const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags used to organize, track, or control access for your flow.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
