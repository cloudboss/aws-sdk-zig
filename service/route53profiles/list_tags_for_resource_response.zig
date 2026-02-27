const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags that are associated with the resource that you specified in the
    /// `ListTagsForResource` request.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
