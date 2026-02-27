const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// List of tags returned by the operation.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
