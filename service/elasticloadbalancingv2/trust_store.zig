const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;

/// Information about a trust store.
pub const TrustStore = struct {
    /// The name of the trust store.
    name: ?[]const u8 = null,

    /// The number of ca certificates in the trust store.
    number_of_ca_certificates: ?i32 = null,

    /// The current status of the trust store.
    status: ?TrustStoreStatus = null,

    /// The number of revoked certificates in the trust store.
    total_revoked_entries: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: ?[]const u8 = null,
};
