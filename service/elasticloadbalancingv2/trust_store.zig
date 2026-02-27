const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;

/// Information about a trust store.
pub const TrustStore = struct {
    /// The name of the trust store.
    name: ?[]const u8,

    /// The number of ca certificates in the trust store.
    number_of_ca_certificates: ?i32,

    /// The current status of the trust store.
    status: ?TrustStoreStatus,

    /// The number of revoked certificates in the trust store.
    total_revoked_entries: ?i64,

    /// The Amazon Resource Name (ARN) of the trust store.
    trust_store_arn: ?[]const u8,
};
