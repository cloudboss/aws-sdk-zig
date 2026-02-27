const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A collection of tags associated with a resource
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
