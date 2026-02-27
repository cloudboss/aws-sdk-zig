const KeyPairIds = @import("key_pair_ids.zig").KeyPairIds;

/// A list of Amazon Web Services accounts and the active CloudFront key pairs
/// in each account that CloudFront can use to verify the signatures of signed
/// URLs and signed cookies.
pub const Signer = struct {
    /// An Amazon Web Services account number that contains active CloudFront key
    /// pairs that CloudFront can use to verify the signatures of signed URLs and
    /// signed cookies. If the Amazon Web Services account that owns the key pairs
    /// is the same account that owns the CloudFront distribution, the value of this
    /// field is `self`.
    aws_account_number: ?[]const u8,

    /// A list of CloudFront key pair identifiers.
    key_pair_ids: ?KeyPairIds,
};
