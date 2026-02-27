const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Tags attached to the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
