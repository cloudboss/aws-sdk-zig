const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// List of tags returned by the ListTagsForResource operation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
