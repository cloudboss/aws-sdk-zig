/// Describes a snapshot.
pub const Snapshot = struct {
    /// The time when the snapshot was created.
    snapshot_time: ?i64 = null,

    pub const json_field_names = .{
        .snapshot_time = "SnapshotTime",
    };
};
