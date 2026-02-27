const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with the specified topic.
    tags: ?[]const Tag,
};
