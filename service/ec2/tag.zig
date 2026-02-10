/// Describes a tag.
pub const Tag = struct {
    /// The key of the tag.
    ///
    /// Constraints: Tag keys are case-sensitive and accept a maximum of 127 Unicode
    /// characters.
    /// May not begin with `aws:`.
    key: ?[]const u8,

    /// The value of the tag.
    ///
    /// Constraints: Tag values are case-sensitive and accept a maximum of 256
    /// Unicode characters.
    value: ?[]const u8,
};
