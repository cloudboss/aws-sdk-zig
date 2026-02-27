const Tag = @import("tag.zig").Tag;

/// Represents the output from the `AddTagsToResource`,
/// `ListTagsForResource`, and `RemoveTagsFromResource`
/// operations.
pub const TagListMessage = struct {
    /// A list of tags as key-value pairs.
    tag_list: ?[]const Tag,
};
