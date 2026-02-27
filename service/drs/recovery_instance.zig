const aws = @import("aws");

const RecoveryInstanceDataReplicationInfo = @import("recovery_instance_data_replication_info.zig").RecoveryInstanceDataReplicationInfo;
const EC2InstanceState = @import("ec2_instance_state.zig").EC2InstanceState;
const RecoveryInstanceFailback = @import("recovery_instance_failback.zig").RecoveryInstanceFailback;
const OriginEnvironment = @import("origin_environment.zig").OriginEnvironment;
const RecoveryInstanceProperties = @import("recovery_instance_properties.zig").RecoveryInstanceProperties;

/// A Recovery Instance is a replica of a Source Server running on EC2.
pub const RecoveryInstance = struct {
    /// The version of the DRS agent installed on the recovery instance
    agent_version: ?[]const u8,

    /// The ARN of the Recovery Instance.
    arn: ?[]const u8,

    /// The Data Replication Info of the Recovery Instance.
    data_replication_info: ?RecoveryInstanceDataReplicationInfo,

    /// The EC2 instance ID of the Recovery Instance.
    ec_2_instance_id: ?[]const u8,

    /// The state of the EC2 instance for this Recovery Instance.
    ec_2_instance_state: ?EC2InstanceState,

    /// An object representing failback related information of the Recovery
    /// Instance.
    failback: ?RecoveryInstanceFailback,

    /// Whether this Recovery Instance was created for a drill or for an actual
    /// Recovery event.
    is_drill: ?bool,

    /// The ID of the Job that created the Recovery Instance.
    job_id: ?[]const u8,

    /// AWS availability zone associated with the recovery instance.
    origin_availability_zone: ?[]const u8,

    /// Environment (On Premises / AWS) of the instance that the recovery instance
    /// originated from.
    origin_environment: ?OriginEnvironment,

    /// The date and time of the Point in Time (PIT) snapshot that this Recovery
    /// Instance was launched from.
    point_in_time_snapshot_date_time: ?[]const u8,

    /// The ID of the Recovery Instance.
    recovery_instance_id: ?[]const u8,

    /// Properties of the Recovery Instance machine.
    recovery_instance_properties: ?RecoveryInstanceProperties,

    /// The ARN of the source Outpost
    source_outpost_arn: ?[]const u8,

    /// The Source Server ID that this Recovery Instance is associated with.
    source_server_id: ?[]const u8,

    /// An array of tags that are associated with the Recovery Instance.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .agent_version = "agentVersion",
        .arn = "arn",
        .data_replication_info = "dataReplicationInfo",
        .ec_2_instance_id = "ec2InstanceID",
        .ec_2_instance_state = "ec2InstanceState",
        .failback = "failback",
        .is_drill = "isDrill",
        .job_id = "jobID",
        .origin_availability_zone = "originAvailabilityZone",
        .origin_environment = "originEnvironment",
        .point_in_time_snapshot_date_time = "pointInTimeSnapshotDateTime",
        .recovery_instance_id = "recoveryInstanceID",
        .recovery_instance_properties = "recoveryInstanceProperties",
        .source_outpost_arn = "sourceOutpostArn",
        .source_server_id = "sourceServerID",
        .tags = "tags",
    };
};
