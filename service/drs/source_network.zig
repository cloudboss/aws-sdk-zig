const aws = @import("aws");

const RecoveryLifeCycle = @import("recovery_life_cycle.zig").RecoveryLifeCycle;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// The ARN of the Source Network.
pub const SourceNetwork = struct {
    /// The ARN of the Source Network.
    arn: ?[]const u8 = null,

    /// CloudFormation stack name that was deployed for recovering the Source
    /// Network.
    cfn_stack_name: ?[]const u8 = null,

    /// An object containing information regarding the last recovery of the Source
    /// Network.
    last_recovery: ?RecoveryLifeCycle = null,

    /// ID of the recovered VPC following Source Network recovery.
    launched_vpc_id: ?[]const u8 = null,

    /// Status of Source Network Replication. Possible values: (a) STOPPED - Source
    /// Network is not replicating. (b) IN_PROGRESS - Source Network is being
    /// replicated. (c) PROTECTED - Source Network was replicated successfully and
    /// is being synchronized for changes. (d) ERROR - Source Network replication
    /// has failed
    replication_status: ?ReplicationStatus = null,

    /// Error details in case Source Network replication status is ERROR.
    replication_status_details: ?[]const u8 = null,

    /// Account ID containing the VPC protected by the Source Network.
    source_account_id: ?[]const u8 = null,

    /// Source Network ID.
    source_network_id: ?[]const u8 = null,

    /// Region containing the VPC protected by the Source Network.
    source_region: ?[]const u8 = null,

    /// VPC ID protected by the Source Network.
    source_vpc_id: ?[]const u8 = null,

    /// A list of tags associated with the Source Network.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cfn_stack_name = "cfnStackName",
        .last_recovery = "lastRecovery",
        .launched_vpc_id = "launchedVpcID",
        .replication_status = "replicationStatus",
        .replication_status_details = "replicationStatusDetails",
        .source_account_id = "sourceAccountID",
        .source_network_id = "sourceNetworkID",
        .source_region = "sourceRegion",
        .source_vpc_id = "sourceVpcID",
        .tags = "tags",
    };
};
