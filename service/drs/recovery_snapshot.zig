/// A snapshot of a Source Server used during recovery.
pub const RecoverySnapshot = struct {
    /// A list of EBS snapshots.
    ebs_snapshots: ?[]const []const u8,

    /// The timestamp of when we expect the snapshot to be taken.
    expected_timestamp: []const u8,

    /// The ID of the Recovery Snapshot.
    snapshot_id: []const u8,

    /// The ID of the Source Server that the snapshot was taken for.
    source_server_id: []const u8,

    /// The actual timestamp that the snapshot was taken.
    timestamp: ?[]const u8,

    pub const json_field_names = .{
        .ebs_snapshots = "ebsSnapshots",
        .expected_timestamp = "expectedTimestamp",
        .snapshot_id = "snapshotID",
        .source_server_id = "sourceServerID",
        .timestamp = "timestamp",
    };
};
