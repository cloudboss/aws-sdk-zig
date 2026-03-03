const DataReplication = @import("data_replication.zig").DataReplication;

/// Describes the properties of the related standby WorkSpaces.
pub const StandbyWorkspacesProperties = struct {
    /// Indicates whether data replication is enabled, and if enabled, the type of
    /// data replication.
    data_replication: ?DataReplication = null,

    /// The date and time at which the last successful snapshot was taken of the
    /// primary WorkSpace used for replicating data.
    recovery_snapshot_time: ?i64 = null,

    /// The identifier of the standby WorkSpace
    standby_workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_replication = "DataReplication",
        .recovery_snapshot_time = "RecoverySnapshotTime",
        .standby_workspace_id = "StandbyWorkspaceId",
    };
};
