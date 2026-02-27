const Tags = @import("tags.zig").Tags;

/// The returned result of the corresponding request.
pub const ListTagsForResourceResult = struct {
    /// A complex type that contains zero or more `Tag` elements.
    tags: Tags,
};
