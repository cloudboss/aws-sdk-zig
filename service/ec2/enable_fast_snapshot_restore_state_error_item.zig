const EnableFastSnapshotRestoreStateError = @import("enable_fast_snapshot_restore_state_error.zig").EnableFastSnapshotRestoreStateError;

/// Contains information about an error that occurred when enabling fast
/// snapshot restores.
pub const EnableFastSnapshotRestoreStateErrorItem = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The error.
    @"error": ?EnableFastSnapshotRestoreStateError = null,
};
