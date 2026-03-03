const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of key-value tags assigned to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
