const Tag = @import("tag.zig").Tag;

/// If the action is successful, the service sends back an
/// HTTP 200 response.
pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the rescore execution
    /// plan.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
