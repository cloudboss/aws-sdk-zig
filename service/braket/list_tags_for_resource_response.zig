const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Displays the key, value pairs of tags associated with this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
