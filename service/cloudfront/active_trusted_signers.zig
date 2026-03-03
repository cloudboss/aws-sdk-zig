const Signer = @import("signer.zig").Signer;

/// A list of Amazon Web Services accounts and the active CloudFront key pairs
/// in each account that CloudFront can use to verify the signatures of signed
/// URLs and signed cookies.
pub const ActiveTrustedSigners = struct {
    /// This field is `true` if any of the Amazon Web Services accounts in the list
    /// are configured as trusted signers. If not, this field is `false`.
    enabled: bool,

    /// A list of Amazon Web Services accounts and the identifiers of active
    /// CloudFront key pairs in each account that CloudFront can use to verify the
    /// signatures of signed URLs and signed cookies.
    items: ?[]const Signer = null,

    /// The number of Amazon Web Services accounts in the list.
    quantity: i32,
};
