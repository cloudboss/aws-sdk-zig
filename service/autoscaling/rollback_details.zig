const InstanceRefreshProgressDetails = @import("instance_refresh_progress_details.zig").InstanceRefreshProgressDetails;

/// Details about an instance refresh rollback.
pub const RollbackDetails = struct {
    /// Indicates the value of `InstancesToUpdate` at the time the rollback
    /// started.
    instances_to_update_on_rollback: ?i32 = null,

    /// Indicates the value of `PercentageComplete` at the time the rollback
    /// started.
    percentage_complete_on_rollback: ?i32 = null,

    /// Reports progress on replacing instances in an Auto Scaling group that has a
    /// warm pool. This
    /// includes separate details for instances in the warm pool and instances in
    /// the Auto Scaling group
    /// (the live pool).
    progress_details_on_rollback: ?InstanceRefreshProgressDetails = null,

    /// The reason for this instance refresh rollback (for example, whether a manual
    /// or
    /// automatic rollback was initiated).
    rollback_reason: ?[]const u8 = null,

    /// The date and time at which the rollback began.
    rollback_start_time: ?i64 = null,
};
