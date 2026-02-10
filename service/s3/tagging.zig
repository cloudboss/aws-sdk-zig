const Tag = @import("tag.zig").Tag;

/// Container for `TagSet` elements.
pub const Tagging = struct {
    /// A collection for a set of tags
    tag_set: []const Tag,
};
