const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags associated with the specified resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
