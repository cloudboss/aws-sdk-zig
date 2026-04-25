const AutomaticFailoverStatus = @import("automatic_failover_status.zig").AutomaticFailoverStatus;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const Endpoint = @import("endpoint.zig").Endpoint;
const DataTieringStatus = @import("data_tiering_status.zig").DataTieringStatus;
const GlobalReplicationGroupInfo = @import("global_replication_group_info.zig").GlobalReplicationGroupInfo;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const MultiAZStatus = @import("multi_az_status.zig").MultiAZStatus;
const NetworkType = @import("network_type.zig").NetworkType;
const NodeGroup = @import("node_group.zig").NodeGroup;
const ReplicationGroupPendingModifiedValues = @import("replication_group_pending_modified_values.zig").ReplicationGroupPendingModifiedValues;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;

/// Contains all of the attributes of a specific Valkey or Redis OSS replication
/// group.
pub const ReplicationGroup = struct {
    /// The ARN (Amazon Resource Name) of the replication group.
    arn: ?[]const u8 = null,

    /// A flag that enables encryption at-rest when set to `true`.
    ///
    /// You cannot modify the value of `AtRestEncryptionEnabled` after the cluster
    /// is created. To enable encryption at-rest on a cluster you must set
    /// `AtRestEncryptionEnabled` to `true` when you create a
    /// cluster.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    ///
    /// Default: `false`
    at_rest_encryption_enabled: ?bool = null,

    /// A flag that enables using an `AuthToken` (password) when issuing Valkey or
    /// Redis OSS
    /// commands.
    ///
    /// Default: `false`
    auth_token_enabled: ?bool = null,

    /// The date the auth token was last modified
    auth_token_last_modified_date: ?i64 = null,

    /// Indicates the status of automatic failover for this Valkey or Redis OSS
    /// replication group.
    automatic_failover: ?AutomaticFailoverStatus = null,

    /// If you are running Valkey 7.2 and above, or Redis OSS engine version 6.0 and
    /// above, set this parameter to yes if you
    /// want to opt-in to the next auto minor version upgrade campaign. This
    /// parameter is
    /// disabled for previous versions.
    auto_minor_version_upgrade: ?bool = null,

    /// The name of the compute and memory capacity node type for each node in the
    /// replication
    /// group.
    cache_node_type: ?[]const u8 = null,

    /// A flag indicating whether or not this replication group is cluster enabled;
    /// i.e.,
    /// whether its data can be partitioned across multiple shards (API/CLI: node
    /// groups).
    ///
    /// Valid values: `true` | `false`
    cluster_enabled: ?bool = null,

    /// Enabled or Disabled. To modify cluster mode from Disabled to Enabled, you
    /// must first
    /// set the cluster mode to Compatible. Compatible mode allows your Valkey or
    /// Redis OSS clients to connect
    /// using both cluster mode enabled and cluster mode disabled. After you migrate
    /// all Valkey or Redis OSS
    /// clients to use cluster mode enabled, you can then complete cluster mode
    /// configuration
    /// and set the cluster mode to Enabled.
    cluster_mode: ?ClusterMode = null,

    /// The configuration endpoint for this replication group. Use the configuration
    /// endpoint
    /// to connect to this replication group.
    configuration_endpoint: ?Endpoint = null,

    /// Enables data tiering. Data tiering is only supported for replication groups
    /// using the
    /// r6gd node type. This parameter must be set to true when using r6gd nodes.
    /// For more
    /// information, see [Data
    /// tiering](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/data-tiering.html).
    data_tiering: ?DataTieringStatus = null,

    /// The user supplied description of the replication group.
    description: ?[]const u8 = null,

    /// The engine used in a replication group. The options are valkey, memcached or
    /// redis.
    engine: ?[]const u8 = null,

    /// The name of the Global datastore and role of this replication group in the
    /// Global
    /// datastore.
    global_replication_group_info: ?GlobalReplicationGroupInfo = null,

    /// The network type you choose when modifying a cluster, either `ipv4` |
    /// `ipv6`. IPv6 is supported for workloads using Valkey 7.2 and above, Redis
    /// OSS engine version 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    ip_discovery: ?IpDiscovery = null,

    /// The ID of the KMS key used to encrypt the disk in the cluster.
    kms_key_id: ?[]const u8 = null,

    /// Returns the destination, format and type of the logs.
    log_delivery_configurations: ?[]const LogDeliveryConfiguration = null,

    /// The names of all the cache clusters that are part of this replication group.
    member_clusters: ?[]const []const u8 = null,

    /// The outpost ARNs of the replication group's member clusters.
    member_clusters_outpost_arns: ?[]const []const u8 = null,

    /// A flag indicating if you have Multi-AZ enabled to enhance fault tolerance.
    /// For more
    /// information, see [Minimizing Downtime:
    /// Multi-AZ](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/AutoFailover.html)
    multi_az: ?MultiAZStatus = null,

    /// Must be either `ipv4` | `ipv6` | `dual_stack`. IPv6
    /// is supported for workloads using Valkey 7.2 and above, Redis OSS engine
    /// version 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    network_type: ?NetworkType = null,

    /// A list of node groups in this replication group. For Valkey or Redis OSS
    /// (cluster mode disabled)
    /// replication groups, this is a single-element list. For Valkey or Redis OSS
    /// (cluster mode enabled)
    /// replication groups, the list contains an entry for each node group (shard).
    node_groups: ?[]const NodeGroup = null,

    /// A group of settings to be applied to the replication group, either
    /// immediately or
    /// during the next maintenance window.
    pending_modified_values: ?ReplicationGroupPendingModifiedValues = null,

    /// The date and time when the cluster was created.
    replication_group_create_time: ?i64 = null,

    /// The identifier for the replication group.
    replication_group_id: ?[]const u8 = null,

    /// The number of days for which ElastiCache retains automatic cluster snapshots
    /// before
    /// deleting them. For example, if you set `SnapshotRetentionLimit` to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    ///
    /// If the value of `SnapshotRetentionLimit` is set to zero (0), backups
    /// are turned off.
    snapshot_retention_limit: ?i32 = null,

    /// The cluster ID that is used as the daily snapshot source for the replication
    /// group.
    snapshotting_cluster_id: ?[]const u8 = null,

    /// The daily time range (in UTC) during which ElastiCache begins taking a daily
    /// snapshot
    /// of your node group (shard).
    ///
    /// Example: `05:00-09:00`
    ///
    /// If you do not specify this parameter, ElastiCache automatically chooses an
    /// appropriate
    /// time range.
    ///
    /// This parameter is only valid if the `Engine` parameter is
    /// `redis`.
    snapshot_window: ?[]const u8 = null,

    /// The current state of this replication group - `creating`,
    /// `available`, `modifying`, `deleting`,
    /// `create-failed`, `snapshotting`.
    status: ?[]const u8 = null,

    /// A flag that enables in-transit encryption when set to `true`.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    ///
    /// Default: `false`
    transit_encryption_enabled: ?bool = null,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    transit_encryption_mode: ?TransitEncryptionMode = null,

    /// The ID of the user group associated to the replication group.
    user_group_ids: ?[]const []const u8 = null,
};
