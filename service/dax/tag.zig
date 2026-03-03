/// A description of a tag. Every tag is a key-value pair. You can add up to 50
/// tags to
/// a single DAX cluster.
///
/// Amazon Web Services-assigned tag names and values are automatically assigned
/// the
/// `aws:` prefix, which the user cannot assign. Amazon Web Services-assigned
/// tag names do not count towards the tag limit of 50. User-assigned tag names
/// have the
/// prefix `user:`.
///
/// You cannot backdate the application of a tag.
pub const Tag = struct {
    /// The key for the tag. Tag keys are case sensitive. Every DAX cluster
    /// can only have one tag with the same key. If you try to add an existing tag
    /// (same key),
    /// the existing tag value will be updated to the new value.
    key: ?[]const u8 = null,

    /// The value of the tag. Tag values are case-sensitive and can be null.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
