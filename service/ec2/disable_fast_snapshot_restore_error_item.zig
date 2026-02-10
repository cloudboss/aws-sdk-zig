const DisableFastSnapshotRestoreStateErrorItem = @import("disable_fast_snapshot_restore_state_error_item.zig").DisableFastSnapshotRestoreStateErrorItem;

/// Contains information about the errors that occurred when disabling fast
/// snapshot restores.
pub const DisableFastSnapshotRestoreErrorItem = struct {
    /// The errors.
    fast_snapshot_restore_state_errors: ?[]const DisableFastSnapshotRestoreStateErrorItem,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,
};
