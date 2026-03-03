/// A list of key groups whose public keys CloudFront can use to verify the
/// signatures of signed URLs and signed cookies.
pub const TrustedKeyGroups = struct {
    /// This field is `true` if any of the key groups in the list have public keys
    /// that CloudFront can use to verify the signatures of signed URLs and signed
    /// cookies. If not, this field is `false`.
    enabled: bool,

    /// A list of key groups identifiers.
    items: ?[]const []const u8 = null,

    /// The number of key groups in the list.
    quantity: i32,
};
