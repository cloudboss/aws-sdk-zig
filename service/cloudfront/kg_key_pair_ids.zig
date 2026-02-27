const KeyPairIds = @import("key_pair_ids.zig").KeyPairIds;

/// A list of identifiers for the public keys that CloudFront can use to verify
/// the signatures of signed URLs and signed cookies.
pub const KGKeyPairIds = struct {
    /// The identifier of the key group that contains the public keys.
    key_group_id: ?[]const u8,

    key_pair_ids: ?KeyPairIds,
};
