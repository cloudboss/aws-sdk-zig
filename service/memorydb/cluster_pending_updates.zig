const ACLsUpdateStatus = @import("ac_ls_update_status.zig").ACLsUpdateStatus;
const ReshardingStatus = @import("resharding_status.zig").ReshardingStatus;
const PendingModifiedServiceUpdate = @import("pending_modified_service_update.zig").PendingModifiedServiceUpdate;

/// A list of updates being applied to the cluster
pub const ClusterPendingUpdates = struct {
    /// A list of ACLs associated with the cluster that are being updated
    ac_ls: ?ACLsUpdateStatus,

    /// The status of an online resharding operation.
    resharding: ?ReshardingStatus,

    /// A list of service updates being applied to the cluster
    service_updates: ?[]const PendingModifiedServiceUpdate,

    pub const json_field_names = .{
        .ac_ls = "ACLs",
        .resharding = "Resharding",
        .service_updates = "ServiceUpdates",
    };
};
