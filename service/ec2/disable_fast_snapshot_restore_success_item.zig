const FastSnapshotRestoreStateCode = @import("fast_snapshot_restore_state_code.zig").FastSnapshotRestoreStateCode;

/// Describes fast snapshot restores that were successfully disabled.
pub const DisableFastSnapshotRestoreSuccessItem = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The time at which fast snapshot restores entered the `disabled` state.
    disabled_time: ?i64 = null,

    /// The time at which fast snapshot restores entered the `disabling` state.
    disabling_time: ?i64 = null,

    /// The time at which fast snapshot restores entered the `enabled` state.
    enabled_time: ?i64 = null,

    /// The time at which fast snapshot restores entered the `enabling` state.
    enabling_time: ?i64 = null,

    /// The time at which fast snapshot restores entered the `optimizing` state.
    optimizing_time: ?i64 = null,

    /// The Amazon Web Services owner alias that enabled fast snapshot restores on
    /// the snapshot. This is intended for future use.
    owner_alias: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that enabled fast snapshot
    /// restores on the snapshot.
    owner_id: ?[]const u8 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    /// The state of fast snapshot restores for the snapshot.
    state: ?FastSnapshotRestoreStateCode = null,

    /// The reason for the state transition. The possible values are as follows:
    ///
    /// * `Client.UserInitiated` - The state successfully transitioned to `enabling`
    ///   or
    /// `disabling`.
    ///
    /// * `Client.UserInitiated - Lifecycle state transition` - The state
    ///   successfully transitioned
    /// to `optimizing`, `enabled`, or `disabled`.
    state_transition_reason: ?[]const u8 = null,
};
