const Tag = @import("tag.zig").Tag;

/// Represents the output of ListTagsForResource.
pub const TagListMessage = struct {
    /// A list of one or more tags.
    tag_list: ?[]const Tag = null,
};
