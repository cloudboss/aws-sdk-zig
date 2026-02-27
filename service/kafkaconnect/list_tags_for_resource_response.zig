const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Lists the tags attached to the specified resource in the corresponding
    /// request.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
