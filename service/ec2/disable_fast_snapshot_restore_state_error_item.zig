const DisableFastSnapshotRestoreStateError = @import("disable_fast_snapshot_restore_state_error.zig").DisableFastSnapshotRestoreStateError;

/// Contains information about an error that occurred when disabling fast
/// snapshot restores.
pub const DisableFastSnapshotRestoreStateErrorItem = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// The error.
    @"error": ?DisableFastSnapshotRestoreStateError,
};
