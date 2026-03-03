const KGKeyPairIds = @import("kg_key_pair_ids.zig").KGKeyPairIds;

/// A list of key groups, and the public keys in each key group, that CloudFront
/// can use to verify the signatures of signed URLs and signed cookies.
pub const ActiveTrustedKeyGroups = struct {
    /// This field is `true` if any of the key groups have public keys that
    /// CloudFront can use to verify the signatures of signed URLs and signed
    /// cookies. If not, this field is `false`.
    enabled: bool,

    /// A list of key groups, including the identifiers of the public keys in each
    /// key group that CloudFront can use to verify the signatures of signed URLs
    /// and signed cookies.
    items: ?[]const KGKeyPairIds = null,

    /// The number of key groups in the list.
    quantity: i32,
};
