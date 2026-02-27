const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with a resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
