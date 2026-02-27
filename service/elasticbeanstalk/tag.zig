/// Describes a tag applied to a resource in an environment.
pub const Tag = struct {
    /// The key of the tag.
    key: ?[]const u8,

    /// The value of the tag.
    value: ?[]const u8,
};
