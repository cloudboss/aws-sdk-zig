/// A container for a key-value name pair.
pub const S3Tag = struct {
    /// Key of the tag
    key: []const u8,

    /// Value of the tag
    value: []const u8,
};
