const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The string that specifies the next page of results.
    next_token: ?[]const u8 = null,

    /// Metadata that you can use to manage a resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
