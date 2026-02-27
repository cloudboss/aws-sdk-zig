/// An object representing the Source Server to recover.
pub const StartRecoveryRequestSourceServer = struct {
    /// The ID of a Recovery Snapshot we want to recover from. Omit this field to
    /// launch from the latest data by taking an on-demand snapshot.
    recovery_snapshot_id: ?[]const u8,

    /// The ID of the Source Server you want to recover.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .recovery_snapshot_id = "recoverySnapshotID",
        .source_server_id = "sourceServerID",
    };
};
