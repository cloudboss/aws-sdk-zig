const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A collection of tags that have been assigned to the specified resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
