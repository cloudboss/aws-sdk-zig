const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A set of tags (key-value pairs) that are part of the requested resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
