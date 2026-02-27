/// Describes the status of a cluster restore action. Returns null if the
/// cluster was
/// not created by restoring a snapshot.
pub const RestoreStatus = struct {
    /// The number of megabytes per second being transferred from the backup
    /// storage.
    /// Returns the average rate for a completed backup.
    /// This field is only updated when you restore to DC2 node types.
    current_restore_rate_in_mega_bytes_per_second: ?f64,

    /// The amount of time an in-progress restore has been running, or the amount of
    /// time
    /// it took a completed restore to finish.
    /// This field is only updated when you restore to DC2 node types.
    elapsed_time_in_seconds: ?i64,

    /// The estimate of the time remaining before the restore will complete. Returns
    /// 0 for
    /// a completed restore.
    /// This field is only updated when you restore to DC2 node types.
    estimated_time_to_completion_in_seconds: ?i64,

    /// The number of megabytes that have been transferred from snapshot storage.
    /// This field is only updated when you restore to DC2 node types.
    progress_in_mega_bytes: ?i64,

    /// The size of the set of snapshot data used to restore the cluster.
    /// This field is only updated when you restore to DC2 node types.
    snapshot_size_in_mega_bytes: ?i64,

    /// The status of the restore action. Returns starting, restoring, completed, or
    /// failed.
    status: ?[]const u8,
};
