const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

/// ListTagsForResourceResponse
pub const ListTagsForResourceResponse = struct {
    /// The opaque string that indicates the position to begin the next list of
    /// results in the
    /// response.
    next_token: ?[]const u8,

    /// An array of tags applied to the specified resource.
    tags: ?[]const TagListEntry,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
