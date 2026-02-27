const DataReplication = @import("data_replication.zig").DataReplication;

/// Describes the data replication settings.
pub const DataReplicationSettings = struct {
    /// Indicates whether data replication is enabled, and if enabled, the type of
    /// data replication.
    data_replication: ?DataReplication,

    /// The date and time at which the last successful snapshot was taken of the
    /// primary WorkSpace used for replicating data.
    recovery_snapshot_time: ?i64,

    pub const json_field_names = .{
        .data_replication = "DataReplication",
        .recovery_snapshot_time = "RecoverySnapshotTime",
    };
};
