const Tag = @import("tag.zig").Tag;

/// A complex type that contains zero or more `Tag` elements.
pub const Tags = struct {
    /// A complex type that contains `Tag` elements.
    items: ?[]const Tag = null,
};
