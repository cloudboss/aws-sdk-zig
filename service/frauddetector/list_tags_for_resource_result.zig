const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// The next token for subsequent requests.
    next_token: ?[]const u8 = null,

    /// A collection of key and value pairs.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .tags = "tags",
    };
};
