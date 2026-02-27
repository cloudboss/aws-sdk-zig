const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8,

    /// The tags that are assigned to the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
