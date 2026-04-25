const aws = @import("aws");

/// Output for the `ListTagsForResource` operation.
pub const ListTagsForResourceResponse = struct {
    /// Tags assigned to a resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
