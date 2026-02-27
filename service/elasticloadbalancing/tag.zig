/// Information about a tag.
pub const Tag = struct {
    /// The key of the tag.
    key: []const u8,

    /// The value of the tag.
    value: ?[]const u8,
};
