/// Contains manual snapshot limit information for a directory.
pub const SnapshotLimits = struct {
    /// The current number of manual snapshots of the directory.
    manual_snapshots_current_count: ?i32,

    /// The maximum number of manual snapshots allowed.
    manual_snapshots_limit: ?i32,

    /// Indicates if the manual snapshot limit has been reached.
    manual_snapshots_limit_reached: bool = false,

    pub const json_field_names = .{
        .manual_snapshots_current_count = "ManualSnapshotsCurrentCount",
        .manual_snapshots_limit = "ManualSnapshotsLimit",
        .manual_snapshots_limit_reached = "ManualSnapshotsLimitReached",
    };
};
