const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The string that specifies the next page of results.
    next_token: ?[]const u8,

    /// Metadata that you can use to manage a resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
