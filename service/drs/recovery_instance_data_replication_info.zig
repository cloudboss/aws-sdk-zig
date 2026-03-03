const RecoveryInstanceDataReplicationError = @import("recovery_instance_data_replication_error.zig").RecoveryInstanceDataReplicationError;
const RecoveryInstanceDataReplicationInitiation = @import("recovery_instance_data_replication_initiation.zig").RecoveryInstanceDataReplicationInitiation;
const RecoveryInstanceDataReplicationState = @import("recovery_instance_data_replication_state.zig").RecoveryInstanceDataReplicationState;
const RecoveryInstanceDataReplicationInfoReplicatedDisk = @import("recovery_instance_data_replication_info_replicated_disk.zig").RecoveryInstanceDataReplicationInfoReplicatedDisk;

/// Information about Data Replication
pub const RecoveryInstanceDataReplicationInfo = struct {
    /// Information about Data Replication
    data_replication_error: ?RecoveryInstanceDataReplicationError = null,

    /// Information about whether the data replication has been initiated.
    data_replication_initiation: ?RecoveryInstanceDataReplicationInitiation = null,

    /// The state of the data replication.
    data_replication_state: ?RecoveryInstanceDataReplicationState = null,

    /// An estimate of when the data replication will be completed.
    eta_date_time: ?[]const u8 = null,

    /// Data replication lag duration.
    lag_duration: ?[]const u8 = null,

    /// The disks that should be replicated.
    replicated_disks: ?[]const RecoveryInstanceDataReplicationInfoReplicatedDisk = null,

    /// AWS Availability zone into which data is being replicated.
    staging_availability_zone: ?[]const u8 = null,

    /// The ARN of the staging Outpost
    staging_outpost_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_replication_error = "dataReplicationError",
        .data_replication_initiation = "dataReplicationInitiation",
        .data_replication_state = "dataReplicationState",
        .eta_date_time = "etaDateTime",
        .lag_duration = "lagDuration",
        .replicated_disks = "replicatedDisks",
        .staging_availability_zone = "stagingAvailabilityZone",
        .staging_outpost_arn = "stagingOutpostArn",
    };
};
