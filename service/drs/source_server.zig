const aws = @import("aws");

const DataReplicationInfo = @import("data_replication_info.zig").DataReplicationInfo;
const LastLaunchResult = @import("last_launch_result.zig").LastLaunchResult;
const LifeCycle = @import("life_cycle.zig").LifeCycle;
const ReplicationDirection = @import("replication_direction.zig").ReplicationDirection;
const SourceCloudProperties = @import("source_cloud_properties.zig").SourceCloudProperties;
const SourceProperties = @import("source_properties.zig").SourceProperties;
const StagingArea = @import("staging_area.zig").StagingArea;

pub const SourceServer = struct {
    /// The version of the DRS agent installed on the source server
    agent_version: ?[]const u8 = null,

    /// The ARN of the Source Server.
    arn: ?[]const u8 = null,

    /// The Data Replication Info of the Source Server.
    data_replication_info: ?DataReplicationInfo = null,

    /// The status of the last recovery launch of this Source Server.
    last_launch_result: ?LastLaunchResult = null,

    /// The lifecycle information of this Source Server.
    life_cycle: ?LifeCycle = null,

    /// The ID of the Recovery Instance associated with this Source Server.
    recovery_instance_id: ?[]const u8 = null,

    /// Replication direction of the Source Server.
    replication_direction: ?ReplicationDirection = null,

    /// For EC2-originated Source Servers which have been failed over and then
    /// failed back, this value will mean the ARN of the Source Server on the
    /// opposite replication direction.
    reversed_direction_source_server_arn: ?[]const u8 = null,

    /// Source cloud properties of the Source Server.
    source_cloud_properties: ?SourceCloudProperties = null,

    /// ID of the Source Network which is protecting this Source Server's network.
    source_network_id: ?[]const u8 = null,

    /// The source properties of the Source Server.
    source_properties: ?SourceProperties = null,

    /// The ID of the Source Server.
    source_server_id: ?[]const u8 = null,

    /// The staging area of the source server.
    staging_area: ?StagingArea = null,

    /// The tags associated with the Source Server.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_version = "agentVersion",
        .arn = "arn",
        .data_replication_info = "dataReplicationInfo",
        .last_launch_result = "lastLaunchResult",
        .life_cycle = "lifeCycle",
        .recovery_instance_id = "recoveryInstanceId",
        .replication_direction = "replicationDirection",
        .reversed_direction_source_server_arn = "reversedDirectionSourceServerArn",
        .source_cloud_properties = "sourceCloudProperties",
        .source_network_id = "sourceNetworkID",
        .source_properties = "sourceProperties",
        .source_server_id = "sourceServerID",
        .staging_area = "stagingArea",
        .tags = "tags",
    };
};
