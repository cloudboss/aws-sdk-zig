const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Tags that have been applied to the specified resource. Tags are mapped from
    /// the tag key to the tag value: `"TagKey" : "TagValue"`.
    ///
    /// * Format example: `{"tag1" : "value1", "tag2" : "value2"} `
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
