const Tag = @import("tag.zig").Tag;

pub const TagListMessage = struct {
    /// List of tags returned by the ListTagsForResource operation.
    tag_list: ?[]const Tag = null,
};
