const ShardDetail = @import("shard_detail.zig").ShardDetail;

/// A list of cluster configuration options.
pub const ClusterConfiguration = struct {
    /// The description of the cluster configuration
    description: ?[]const u8 = null,

    /// The name of the engine used by the cluster configuration.
    engine: ?[]const u8 = null,

    /// The Redis OSS engine version used by the cluster
    engine_version: ?[]const u8 = null,

    /// The specified maintenance window for the cluster
    maintenance_window: ?[]const u8 = null,

    /// The name for the multi-Region cluster associated with the cluster
    /// configuration.
    multi_region_cluster_name: ?[]const u8 = null,

    /// The name of the multi-Region parameter group associated with the cluster
    /// configuration.
    multi_region_parameter_group_name: ?[]const u8 = null,

    /// The name of the cluster
    name: ?[]const u8 = null,

    /// The node type used for the cluster
    node_type: ?[]const u8 = null,

    /// The number of shards in the cluster
    num_shards: ?i32 = null,

    /// The name of parameter group used by the cluster
    parameter_group_name: ?[]const u8 = null,

    /// The port used by the cluster
    port: ?i32 = null,

    /// The list of shards in the cluster
    shards: ?[]const ShardDetail = null,

    /// The snapshot retention limit set by the cluster
    snapshot_retention_limit: ?i32 = null,

    /// The snapshot window set by the cluster
    snapshot_window: ?[]const u8 = null,

    /// The name of the subnet group used by the cluster
    subnet_group_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the SNS notification topic for the cluster
    topic_arn: ?[]const u8 = null,

    /// The ID of the VPC the cluster belongs to
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .maintenance_window = "MaintenanceWindow",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .multi_region_parameter_group_name = "MultiRegionParameterGroupName",
        .name = "Name",
        .node_type = "NodeType",
        .num_shards = "NumShards",
        .parameter_group_name = "ParameterGroupName",
        .port = "Port",
        .shards = "Shards",
        .snapshot_retention_limit = "SnapshotRetentionLimit",
        .snapshot_window = "SnapshotWindow",
        .subnet_group_name = "SubnetGroupName",
        .topic_arn = "TopicArn",
        .vpc_id = "VpcId",
    };
};
