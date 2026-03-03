const aws = @import("aws");

/// The response to the request.
pub const ListTagsForResourceResponse = struct {
    /// The tags that are applied to the specified resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
