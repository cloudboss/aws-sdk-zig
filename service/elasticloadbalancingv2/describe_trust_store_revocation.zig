const RevocationType = @import("revocation_type.zig").RevocationType;

/// Information about the revocations used by a trust store.
pub const DescribeTrustStoreRevocation = struct {
    /// The number of revoked certificates.
    number_of_revoked_entries: ?i64 = null,

    /// The revocation ID of a revocation file in use.
    revocation_id: ?i64 = null,

    /// The type of revocation file.
    revocation_type: ?RevocationType = null,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: ?[]const u8 = null,
};
