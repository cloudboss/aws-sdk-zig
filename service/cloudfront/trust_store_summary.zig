const TrustStoreStatus = @import("trust_store_status.zig").TrustStoreStatus;

/// A trust store summary.
pub const TrustStoreSummary = struct {
    /// The trust store's Amazon Resource Name (ARN).
    arn: []const u8,

    /// The version identifier for the current version of the trust store.
    e_tag: []const u8,

    /// The trust store's ID.
    id: []const u8,

    /// The trust store's last modified time.
    last_modified_time: i64,

    /// The trust store's name.
    name: []const u8,

    /// The trust store's number of CA certificates.
    number_of_ca_certificates: i32,

    /// The trust store's reason.
    reason: ?[]const u8 = null,

    /// The trust store's status.
    status: TrustStoreStatus,
};
