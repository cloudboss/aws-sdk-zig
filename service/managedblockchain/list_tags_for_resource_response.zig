const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags assigned to the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
