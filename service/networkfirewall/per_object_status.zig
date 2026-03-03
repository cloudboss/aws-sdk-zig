const PerObjectSyncStatus = @import("per_object_sync_status.zig").PerObjectSyncStatus;

/// Provides configuration status for a single policy or rule group that is used
/// for a firewall endpoint. Network Firewall
/// provides each endpoint with the rules that are configured in the firewall
/// policy. Each time
/// you add a subnet or modify the associated firewall policy, Network Firewall
/// synchronizes the
/// rules in the endpoint, so it can properly filter network traffic. This is
/// part of a SyncState for a firewall.
pub const PerObjectStatus = struct {
    /// Indicates whether this object is in sync with the version indicated in the
    /// update token.
    sync_status: ?PerObjectSyncStatus = null,

    /// The current version of the object that is either in sync or pending
    /// synchronization.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .sync_status = "SyncStatus",
        .update_token = "UpdateToken",
    };
};
