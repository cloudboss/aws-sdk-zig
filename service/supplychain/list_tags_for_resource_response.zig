const aws = @import("aws");

/// The response parameters of ListTagsForResource.
pub const ListTagsForResourceResponse = struct {
    /// The tags added to an Amazon Web Services Supply Chain resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
