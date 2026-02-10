/// Information about a snapshot that is currently in the Recycle Bin.
pub const SnapshotRecycleBinInfo = struct {
    /// The description for the snapshot.
    description: ?[]const u8,

    /// The date and time when the snapshot entered the Recycle Bin.
    recycle_bin_enter_time: ?i64,

    /// The date and time when the snapshot is to be permanently deleted from the
    /// Recycle Bin.
    recycle_bin_exit_time: ?i64,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,

    /// The ID of the volume from which the snapshot was created.
    volume_id: ?[]const u8,
};
