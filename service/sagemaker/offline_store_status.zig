const OfflineStoreStatusValue = @import("offline_store_status_value.zig").OfflineStoreStatusValue;

/// The status of `OfflineStore`.
pub const OfflineStoreStatus = struct {
    /// The justification for why the OfflineStoreStatus is Blocked (if applicable).
    blocked_reason: ?[]const u8,

    /// An `OfflineStore` status.
    status: OfflineStoreStatusValue,

    pub const json_field_names = .{
        .blocked_reason = "BlockedReason",
        .status = "Status",
    };
};
