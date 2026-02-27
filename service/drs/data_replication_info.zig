const DataReplicationError = @import("data_replication_error.zig").DataReplicationError;
const DataReplicationInitiation = @import("data_replication_initiation.zig").DataReplicationInitiation;
const DataReplicationState = @import("data_replication_state.zig").DataReplicationState;
const DataReplicationInfoReplicatedDisk = @import("data_replication_info_replicated_disk.zig").DataReplicationInfoReplicatedDisk;

/// Information about Data Replication
pub const DataReplicationInfo = struct {
    /// Error in data replication.
    data_replication_error: ?DataReplicationError,

    /// Information about whether the data replication has been initiated.
    data_replication_initiation: ?DataReplicationInitiation,

    /// The state of the data replication.
    data_replication_state: ?DataReplicationState,

    /// An estimate of when the data replication will be completed.
    eta_date_time: ?[]const u8,

    /// Data replication lag duration.
    lag_duration: ?[]const u8,

    /// The disks that should be replicated.
    replicated_disks: ?[]const DataReplicationInfoReplicatedDisk,

    /// AWS Availability zone into which data is being replicated.
    staging_availability_zone: ?[]const u8,

    /// The ARN of the staging Outpost
    staging_outpost_arn: ?[]const u8,

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
