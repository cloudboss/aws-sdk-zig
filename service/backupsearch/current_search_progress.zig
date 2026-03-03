/// This contains information results retrieved from a search job that may not
/// have completed.
pub const CurrentSearchProgress = struct {
    /// This number is the sum of all items that match the item filters in a search
    /// job in progress.
    items_matched_count: ?i64 = null,

    /// This number is the sum of all items that have been scanned so far during a
    /// search job.
    items_scanned_count: ?i64 = null,

    /// This number is the sum of all backups that have been scanned so far during a
    /// search job.
    recovery_points_scanned_count: ?i32 = null,

    pub const json_field_names = .{
        .items_matched_count = "ItemsMatchedCount",
        .items_scanned_count = "ItemsScannedCount",
        .recovery_points_scanned_count = "RecoveryPointsScannedCount",
    };
};
