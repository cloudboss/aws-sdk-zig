/// Represents a tag that is applied to roles that are created from a role
/// template. The key
/// and value can include `@{parameter}` placeholders that are replaced with
/// template parameter values when the role is created.
pub const TagTemplate = struct {
    /// The key name of the tag.
    key: []const u8,

    /// The value associated with the tag key.
    value: []const u8,
};
