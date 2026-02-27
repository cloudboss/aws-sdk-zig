/// A tag consisting of a name/value pair for a resource.
pub const Tag = struct {
    /// The key, or name, for the resource tag.
    key: ?[]const u8,

    /// The value for the resource tag.
    value: ?[]const u8,
};
