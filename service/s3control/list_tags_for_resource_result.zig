const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResult = struct {
    /// The Amazon Web Services resource tags that are associated with the resource.
    tags: ?[]const Tag = null,
};
