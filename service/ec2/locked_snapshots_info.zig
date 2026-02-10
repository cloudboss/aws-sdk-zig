const LockState = @import("lock_state.zig").LockState;

/// Information about a locked snapshot.
pub const LockedSnapshotsInfo = struct {
    /// The compliance mode cooling-off period, in hours.
    cool_off_period: ?i32,

    /// The date and time at which the compliance mode cooling-off period expires,
    /// in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    cool_off_period_expires_on: ?i64,

    /// The date and time at which the snapshot was locked, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    lock_created_on: ?i64,

    /// The period of time for which the snapshot is locked, in days.
    lock_duration: ?i32,

    /// The date and time at which the lock duration started, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    ///
    /// If you lock a snapshot that is in the `pending` state, the lock duration
    /// starts only once the snapshot enters the `completed` state.
    lock_duration_start_time: ?i64,

    /// The date and time at which the lock will expire, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    lock_expires_on: ?i64,

    /// The state of the snapshot lock. Valid states include:
    ///
    /// * `compliance-cooloff` - The snapshot has been locked in
    /// compliance mode but it is still within the cooling-off period. The snapshot
    /// can't be
    /// deleted, but it can be unlocked and the lock settings can be modified by
    /// users with
    /// appropriate permissions.
    ///
    /// * `governance` - The snapshot is locked in governance mode. The
    /// snapshot can't be deleted, but it can be unlocked and the lock settings can
    /// be
    /// modified by users with appropriate permissions.
    ///
    /// * `compliance` - The snapshot is locked in compliance mode and the
    /// cooling-off period has expired. The snapshot can't be unlocked or deleted.
    /// The lock
    /// duration can only be increased by users with appropriate permissions.
    ///
    /// * `expired` - The snapshot was locked in compliance or governance
    /// mode but the lock duration has expired. The snapshot is not locked and can
    /// be deleted.
    lock_state: ?LockState,

    /// The account ID of the Amazon Web Services account that owns the snapshot.
    owner_id: ?[]const u8,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,
};
