/// A source server with a specific recovery snapshot for plan execution.
pub const RecoveryPlanExecutionSourceServer = struct {
    /// The ID of the recovery snapshot to use.
    recovery_snapshot_id: []const u8,

    /// The ID of the source server.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .recovery_snapshot_id = "recoverySnapshotID",
        .source_server_id = "sourceServerID",
    };
};
