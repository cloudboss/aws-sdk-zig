const EnableFastSnapshotRestoreStateErrorItem = @import("enable_fast_snapshot_restore_state_error_item.zig").EnableFastSnapshotRestoreStateErrorItem;

/// Contains information about the errors that occurred when enabling fast
/// snapshot restores.
pub const EnableFastSnapshotRestoreErrorItem = struct {
    /// The errors.
    fast_snapshot_restore_state_errors: ?[]const EnableFastSnapshotRestoreStateErrorItem,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,
};
