const AZStatus = @import("az_status.zig").AZStatus;
const Endpoint = @import("endpoint.zig").Endpoint;
const DataTieringStatus = @import("data_tiering_status.zig").DataTieringStatus;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const NetworkType = @import("network_type.zig").NetworkType;
const ClusterPendingUpdates = @import("cluster_pending_updates.zig").ClusterPendingUpdates;
const SecurityGroupMembership = @import("security_group_membership.zig").SecurityGroupMembership;
const Shard = @import("shard.zig").Shard;

/// Contains all of the attributes of a specific cluster.
pub const Cluster = struct {
    /// The name of the Access Control List associated with this cluster.
    acl_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster.
    arn: ?[]const u8 = null,

    /// When set to true, the cluster will automatically receive minor engine
    /// version upgrades after launch.
    auto_minor_version_upgrade: ?bool = null,

    /// Indicates if the cluster has a Multi-AZ configuration (multiaz) or not
    /// (singleaz).
    availability_mode: ?AZStatus = null,

    /// The cluster's configuration endpoint
    cluster_endpoint: ?Endpoint = null,

    /// Enables data tiering. Data tiering is only supported for clusters using the
    /// r6gd node type.
    /// This parameter must be set when using r6gd nodes. For more information, see
    /// [Data
    /// tiering](https://docs.aws.amazon.com/memorydb/latest/devguide/data-tiering.html).
    data_tiering: ?DataTieringStatus = null,

    /// A description of the cluster
    description: ?[]const u8 = null,

    /// The name of the engine used by the cluster.
    engine: ?[]const u8 = null,

    /// The Redis OSS engine patch version used by the cluster
    engine_patch_version: ?[]const u8 = null,

    /// The Redis OSS engine version used by the cluster
    engine_version: ?[]const u8 = null,

    /// The mechanism that the cluster uses to discover IP addresses. Returns 'ipv4'
    /// when DNS endpoints resolve to IPv4 addresses, or 'ipv6' when DNS endpoints
    /// resolve to IPv6 addresses.
    ip_discovery: ?IpDiscovery = null,

    /// The ID of the KMS key used to encrypt the cluster
    kms_key_id: ?[]const u8 = null,

    /// Specifies the weekly time range during which maintenance on the cluster is
    /// performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi
    /// (24H Clock UTC). The minimum maintenance window is a 60 minute period.
    maintenance_window: ?[]const u8 = null,

    /// The name of the multi-Region cluster that this cluster belongs to.
    multi_region_cluster_name: ?[]const u8 = null,

    /// The user-supplied name of the cluster. This identifier is a unique key that
    /// identifies a cluster.
    name: ?[]const u8 = null,

    /// The IP address type for the cluster. Returns 'ipv4' for IPv4 only, 'ipv6'
    /// for IPv6 only, or 'dual-stack' if the cluster supports both IPv4 and IPv6
    /// addressing.
    network_type: ?NetworkType = null,

    /// The cluster's node type
    node_type: ?[]const u8 = null,

    /// The number of shards in the cluster
    number_of_shards: ?i32 = null,

    /// The name of the parameter group used by the cluster
    parameter_group_name: ?[]const u8 = null,

    /// The status of the parameter group used by the cluster, for example 'active'
    /// or 'applying'.
    parameter_group_status: ?[]const u8 = null,

    /// A group of settings that are currently being applied.
    pending_updates: ?ClusterPendingUpdates = null,

    /// A list of security groups used by the cluster
    security_groups: ?[]const SecurityGroupMembership = null,

    /// A list of shards that are members of the cluster.
    shards: ?[]const Shard = null,

    /// The number of days for which MemoryDB retains automatic snapshots before
    /// deleting them. For example, if you set SnapshotRetentionLimit to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    snapshot_retention_limit: ?i32 = null,

    /// The daily time range (in UTC) during which MemoryDB begins taking a daily
    /// snapshot of your shard.
    ///
    /// Example: 05:00-09:00
    ///
    /// If you do not specify this parameter, MemoryDB automatically chooses an
    /// appropriate time range.
    snapshot_window: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the SNS notification topic
    sns_topic_arn: ?[]const u8 = null,

    /// The SNS topic must be in Active status to receive notifications
    sns_topic_status: ?[]const u8 = null,

    /// The status of the cluster. For example, Available, Updating, Creating.
    status: ?[]const u8 = null,

    /// The name of the subnet group used by the cluster
    subnet_group_name: ?[]const u8 = null,

    /// A flag to indicate if In-transit encryption is enabled
    tls_enabled: ?bool = null,

    pub const json_field_names = .{
        .acl_name = "ACLName",
        .arn = "ARN",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_mode = "AvailabilityMode",
        .cluster_endpoint = "ClusterEndpoint",
        .data_tiering = "DataTiering",
        .description = "Description",
        .engine = "Engine",
        .engine_patch_version = "EnginePatchVersion",
        .engine_version = "EngineVersion",
        .ip_discovery = "IpDiscovery",
        .kms_key_id = "KmsKeyId",
        .maintenance_window = "MaintenanceWindow",
        .multi_region_cluster_name = "MultiRegionClusterName",
        .name = "Name",
        .network_type = "NetworkType",
        .node_type = "NodeType",
        .number_of_shards = "NumberOfShards",
        .parameter_group_name = "ParameterGroupName",
        .parameter_group_status = "ParameterGroupStatus",
        .pending_updates = "PendingUpdates",
        .security_groups = "SecurityGroups",
        .shards = "Shards",
        .snapshot_retention_limit = "SnapshotRetentionLimit",
        .snapshot_window = "SnapshotWindow",
        .sns_topic_arn = "SnsTopicArn",
        .sns_topic_status = "SnsTopicStatus",
        .status = "Status",
        .subnet_group_name = "SubnetGroupName",
        .tls_enabled = "TLSEnabled",
    };
};
