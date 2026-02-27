/// A key-value pair that you use to label your resources. You can add tags to
/// new resources when you create them, or you can add tags to existing
/// resources. Tags can help you organize, track costs for, and control access
/// to resources.
pub const Tag = struct {
    /// The key of the key-value pair of a tag added to your Amazon Web Services
    /// resource. A tag key can be up to 128 Unicode characters in length and is
    /// case-sensitive. System created tags that begin with `aws:` aren’t supported.
    key: []const u8,

    /// The value of the key-value pair of a tag added to your Amazon Web Services
    /// resource. A tag value can be up to 256 Unicode characters in length and is
    /// case-sensitive.
    value: []const u8,
};
