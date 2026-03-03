const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of tags assigned to the specified resource. This is the list of
    /// tags
    /// returned in the response.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
