const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The pagination token for the list API. Initially the value is null. Use the
    /// output of previous API calls to make subsequent calls.
    next_token: ?[]const u8,

    /// A set of key-value pairs that are used to manage the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
