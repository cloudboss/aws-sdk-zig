const Tag = @import("tag.zig").Tag;

pub const ListTagsResponse = struct {
    /// When the list is truncated, this value is present and should be used for the
    /// **NextToken** parameter in a subsequent pagination request.
    next_token: ?[]const u8 = null,

    /// The tags associated with your private CA.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
