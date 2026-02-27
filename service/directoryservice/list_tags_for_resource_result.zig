const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// Reserved for future use.
    next_token: ?[]const u8,

    /// List of tags returned by the ListTagsForResource operation.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
