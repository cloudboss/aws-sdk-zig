/// A list of Amazon Web Services accounts whose public keys CloudFront can use
/// to verify the signatures of signed URLs and signed cookies.
pub const TrustedSigners = struct {
    /// This field is `true` if any of the Amazon Web Services accounts in the list
    /// are configured as trusted signers. If not, this field is `false`.
    enabled: bool,

    /// A list of Amazon Web Services account identifiers.
    items: ?[]const []const u8 = null,

    /// The number of Amazon Web Services accounts in the list.
    quantity: i32,
};
