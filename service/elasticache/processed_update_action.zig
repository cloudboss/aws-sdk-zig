const UpdateActionStatus = @import("update_action_status.zig").UpdateActionStatus;

/// Update action that has been processed for the corresponding apply/stop
/// request
pub const ProcessedUpdateAction = struct {
    /// The ID of the cache cluster
    cache_cluster_id: ?[]const u8 = null,

    /// The ID of the replication group
    replication_group_id: ?[]const u8 = null,

    /// The unique ID of the service update
    service_update_name: ?[]const u8 = null,

    /// The status of the update action on the Valkey or Redis OSS cluster
    update_action_status: ?UpdateActionStatus = null,
};
