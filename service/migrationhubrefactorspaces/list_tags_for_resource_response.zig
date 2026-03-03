const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags assigned to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
