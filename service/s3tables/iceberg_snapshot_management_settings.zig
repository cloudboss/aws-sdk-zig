/// Contains details about the snapshot management settings for an Iceberg
/// table. The oldest snapshot expires when its age exceeds the
/// `maxSnapshotAgeHours` and the total number of snapshots exceeds the value
/// for the minimum number of snapshots to keep `minSnapshotsToKeep`.
pub const IcebergSnapshotManagementSettings = struct {
    /// The maximum age of a snapshot before it can be expired.
    max_snapshot_age_hours: ?i32,

    /// The minimum number of snapshots to keep.
    min_snapshots_to_keep: ?i32,

    pub const json_field_names = .{
        .max_snapshot_age_hours = "maxSnapshotAgeHours",
        .min_snapshots_to_keep = "minSnapshotsToKeep",
    };
};
