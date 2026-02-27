const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The key-value pairs to associate with the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
