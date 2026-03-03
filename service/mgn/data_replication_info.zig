const DataReplicationError = @import("data_replication_error.zig").DataReplicationError;
const DataReplicationInitiation = @import("data_replication_initiation.zig").DataReplicationInitiation;
const DataReplicationState = @import("data_replication_state.zig").DataReplicationState;
const DataReplicationInfoReplicatedDisk = @import("data_replication_info_replicated_disk.zig").DataReplicationInfoReplicatedDisk;

/// Request data replication info.
pub const DataReplicationInfo = struct {
    /// Error in obtaining data replication info.
    data_replication_error: ?DataReplicationError = null,

    /// Request to query whether data replication has been initiated.
    data_replication_initiation: ?DataReplicationInitiation = null,

    /// Request to query the data replication state.
    data_replication_state: ?DataReplicationState = null,

    /// Request to query the time when data replication will be complete.
    eta_date_time: ?[]const u8 = null,

    /// Request to query data replication lag duration.
    lag_duration: ?[]const u8 = null,

    /// Request to query data replication last snapshot time.
    last_snapshot_date_time: ?[]const u8 = null,

    /// Request to query disks replicated.
    replicated_disks: ?[]const DataReplicationInfoReplicatedDisk = null,

    /// Replication server instance ID.
    replicator_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_replication_error = "dataReplicationError",
        .data_replication_initiation = "dataReplicationInitiation",
        .data_replication_state = "dataReplicationState",
        .eta_date_time = "etaDateTime",
        .lag_duration = "lagDuration",
        .last_snapshot_date_time = "lastSnapshotDateTime",
        .replicated_disks = "replicatedDisks",
        .replicator_id = "replicatorId",
    };
};
