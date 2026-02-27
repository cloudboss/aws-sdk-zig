const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The resource tags.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
