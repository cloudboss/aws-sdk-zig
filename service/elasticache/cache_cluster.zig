const CacheNode = @import("cache_node.zig").CacheNode;
const CacheParameterGroupStatus = @import("cache_parameter_group_status.zig").CacheParameterGroupStatus;
const CacheSecurityGroupMembership = @import("cache_security_group_membership.zig").CacheSecurityGroupMembership;
const Endpoint = @import("endpoint.zig").Endpoint;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const LogDeliveryConfiguration = @import("log_delivery_configuration.zig").LogDeliveryConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const SecurityGroupMembership = @import("security_group_membership.zig").SecurityGroupMembership;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;

/// Contains all of the attributes of a specific cluster.
pub const CacheCluster = struct {
    /// The ARN (Amazon Resource Name) of the cache cluster.
    arn: ?[]const u8,

    /// A flag that enables encryption at-rest when set to `true`.
    ///
    /// You cannot modify the value of `AtRestEncryptionEnabled` after the cluster
    /// is created. To enable at-rest encryption on a cluster you must set
    /// `AtRestEncryptionEnabled` to `true` when you create a
    /// cluster.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    ///
    /// Default: `false`
    at_rest_encryption_enabled: ?bool,

    /// A flag that enables using an `AuthToken` (password) when issuing Valkey or
    /// Redis OSS
    /// commands.
    ///
    /// Default: `false`
    auth_token_enabled: ?bool,

    /// The date the auth token was last modified
    auth_token_last_modified_date: ?i64,

    /// If you are running Valkey or Redis OSS engine version 6.0 or later, set this
    /// parameter to yes if
    /// you want to opt-in to the next auto minor version upgrade campaign. This
    /// parameter is
    /// disabled for previous versions.
    auto_minor_version_upgrade: ?bool,

    /// The date and time when the cluster was created.
    cache_cluster_create_time: ?i64,

    /// The user-supplied identifier of the cluster. This identifier is a unique key
    /// that
    /// identifies a cluster.
    cache_cluster_id: ?[]const u8,

    /// The current state of this cluster, one of the following values:
    /// `available`, `creating`, `deleted`,
    /// `deleting`, `incompatible-network`, `modifying`,
    /// `rebooting cluster nodes`, `restore-failed`, or
    /// `snapshotting`.
    cache_cluster_status: ?[]const u8,

    /// A list of cache nodes that are members of the cluster.
    cache_nodes: ?[]const CacheNode,

    /// The name of the compute and memory capacity node type for the cluster.
    ///
    /// The following node types are supported by ElastiCache. Generally speaking,
    /// the current
    /// generation types provide more memory and computational power at lower cost
    /// when compared
    /// to their equivalent previous generation counterparts.
    ///
    /// * General purpose:
    ///
    /// * Current generation:
    ///
    /// **M7g node types**:
    /// `cache.m7g.large`,
    /// `cache.m7g.xlarge`,
    /// `cache.m7g.2xlarge`,
    /// `cache.m7g.4xlarge`,
    /// `cache.m7g.8xlarge`,
    /// `cache.m7g.12xlarge`,
    /// `cache.m7g.16xlarge`
    ///
    /// For region availability, see [Supported Node
    /// Types](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheNodes.SupportedTypes.html#CacheNodes.SupportedTypesByRegion)
    ///
    /// **M6g node types** (available only for Redis OSS engine version 5.0.6 onward
    /// and for Memcached engine version 1.5.16 onward):
    ///
    /// `cache.m6g.large`,
    /// `cache.m6g.xlarge`,
    /// `cache.m6g.2xlarge`,
    /// `cache.m6g.4xlarge`,
    /// `cache.m6g.8xlarge`,
    /// `cache.m6g.12xlarge`,
    /// `cache.m6g.16xlarge`
    ///
    /// **M5 node types:**
    /// `cache.m5.large`,
    /// `cache.m5.xlarge`,
    /// `cache.m5.2xlarge`,
    /// `cache.m5.4xlarge`,
    /// `cache.m5.12xlarge`,
    /// `cache.m5.24xlarge`
    ///
    /// **M4 node types:**
    /// `cache.m4.large`,
    /// `cache.m4.xlarge`,
    /// `cache.m4.2xlarge`,
    /// `cache.m4.4xlarge`,
    /// `cache.m4.10xlarge`
    ///
    /// **T4g node types** (available only for Redis OSS engine version 5.0.6 onward
    /// and Memcached engine version 1.5.16 onward):
    /// `cache.t4g.micro`,
    /// `cache.t4g.small`,
    /// `cache.t4g.medium`
    ///
    /// **T3 node types:**
    /// `cache.t3.micro`,
    /// `cache.t3.small`,
    /// `cache.t3.medium`
    ///
    /// **T2 node types:**
    /// `cache.t2.micro`,
    /// `cache.t2.small`,
    /// `cache.t2.medium`
    ///
    /// * Previous generation: (not recommended. Existing clusters are still
    ///   supported but creation of new clusters is not supported for these types.)
    ///
    /// **T1 node types:**
    /// `cache.t1.micro`
    ///
    /// **M1 node types:**
    /// `cache.m1.small`,
    /// `cache.m1.medium`,
    /// `cache.m1.large`,
    /// `cache.m1.xlarge`
    ///
    /// **M3 node types:**
    /// `cache.m3.medium`,
    /// `cache.m3.large`,
    /// `cache.m3.xlarge`,
    /// `cache.m3.2xlarge`
    ///
    /// * Compute optimized:
    ///
    /// * Previous generation: (not recommended. Existing clusters are still
    ///   supported but creation of new clusters is not supported for these types.)
    ///
    /// **C1 node types:**
    /// `cache.c1.xlarge`
    ///
    /// * Memory optimized:
    ///
    /// * Current generation:
    ///
    /// **R7g node types**:
    /// `cache.r7g.large`,
    /// `cache.r7g.xlarge`,
    /// `cache.r7g.2xlarge`,
    /// `cache.r7g.4xlarge`,
    /// `cache.r7g.8xlarge`,
    /// `cache.r7g.12xlarge`,
    /// `cache.r7g.16xlarge`
    ///
    /// For region availability, see [Supported Node
    /// Types](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheNodes.SupportedTypes.html#CacheNodes.SupportedTypesByRegion)
    ///
    /// **R6g node types** (available only for Redis OSS engine version 5.0.6 onward
    /// and for Memcached engine version 1.5.16 onward):
    /// `cache.r6g.large`,
    /// `cache.r6g.xlarge`,
    /// `cache.r6g.2xlarge`,
    /// `cache.r6g.4xlarge`,
    /// `cache.r6g.8xlarge`,
    /// `cache.r6g.12xlarge`,
    /// `cache.r6g.16xlarge`
    ///
    /// **R5 node types:**
    /// `cache.r5.large`,
    /// `cache.r5.xlarge`,
    /// `cache.r5.2xlarge`,
    /// `cache.r5.4xlarge`,
    /// `cache.r5.12xlarge`,
    /// `cache.r5.24xlarge`
    ///
    /// **R4 node types:**
    /// `cache.r4.large`,
    /// `cache.r4.xlarge`,
    /// `cache.r4.2xlarge`,
    /// `cache.r4.4xlarge`,
    /// `cache.r4.8xlarge`,
    /// `cache.r4.16xlarge`
    ///
    /// * Previous generation: (not recommended. Existing clusters are still
    ///   supported but creation of new clusters is not supported for these types.)
    ///
    /// **M2 node types:**
    /// `cache.m2.xlarge`,
    /// `cache.m2.2xlarge`,
    /// `cache.m2.4xlarge`
    ///
    /// **R3 node types:**
    /// `cache.r3.large`,
    /// `cache.r3.xlarge`,
    /// `cache.r3.2xlarge`,
    /// `cache.r3.4xlarge`,
    /// `cache.r3.8xlarge`
    ///
    /// **Additional node type info**
    ///
    /// * All current generation instance types are created in Amazon VPC by
    /// default.
    ///
    /// * Valkey or Redis OSS append-only files (AOF) are not supported for T1 or T2
    ///   instances.
    ///
    /// * Valkey or Redis OSS Multi-AZ with automatic failover is not supported on
    ///   T1
    /// instances.
    ///
    /// * The configuration variables `appendonly` and
    /// `appendfsync` are not supported on Valkey, or on Redis OSS version 2.8.22
    /// and
    /// later.
    cache_node_type: ?[]const u8,

    /// Status of the cache parameter group.
    cache_parameter_group: ?CacheParameterGroupStatus,

    /// A list of cache security group elements, composed of name and status
    /// sub-elements.
    cache_security_groups: ?[]const CacheSecurityGroupMembership,

    /// The name of the cache subnet group associated with the cluster.
    cache_subnet_group_name: ?[]const u8,

    /// The URL of the web page where you can download the latest ElastiCache client
    /// library.
    client_download_landing_page: ?[]const u8,

    /// Represents a Memcached cluster endpoint which can be used by an application
    /// to connect
    /// to any node in the cluster. The configuration endpoint will always have
    /// `.cfg` in it.
    ///
    /// Example: `mem-3.9dvc4r.cfg.usw2.cache.amazonaws.com:11211`
    configuration_endpoint: ?Endpoint,

    /// The name of the cache engine (`memcached` or `redis`) to be used
    /// for this cluster.
    engine: ?[]const u8,

    /// The version of the cache engine that is used in this cluster.
    engine_version: ?[]const u8,

    /// The network type associated with the cluster, either `ipv4` |
    /// `ipv6`. IPv6 is supported for workloads using Valkey 7.2 and above, Redis
    /// OSS engine version 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    ip_discovery: ?IpDiscovery,

    /// Returns the destination, format and type of the logs.
    log_delivery_configurations: ?[]const LogDeliveryConfiguration,

    /// Must be either `ipv4` | `ipv6` | `dual_stack`. IPv6
    /// is supported for workloads using Valkey 7.2 and above, Redis OSS engine
    /// version 6.2
    /// 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    network_type: ?NetworkType,

    /// Describes a notification topic and its status. Notification topics are used
    /// for
    /// publishing ElastiCache events to subscribers using Amazon Simple
    /// Notification Service
    /// (SNS).
    notification_configuration: ?NotificationConfiguration,

    /// The number of cache nodes in the cluster.
    ///
    /// For clusters running Valkey or Redis OSS, this value must be 1. For clusters
    /// running Memcached, this
    /// value must be between 1 and 40.
    num_cache_nodes: ?i32,

    pending_modified_values: ?PendingModifiedValues,

    /// The name of the Availability Zone in which the cluster is located or
    /// "Multiple" if the
    /// cache nodes are located in different Availability Zones.
    preferred_availability_zone: ?[]const u8,

    /// Specifies the weekly time range during which maintenance on the cluster is
    /// performed.
    /// It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock
    /// UTC). The
    /// minimum maintenance window is a 60 minute period.
    ///
    /// Valid values for `ddd` are:
    ///
    /// * `sun`
    ///
    /// * `mon`
    ///
    /// * `tue`
    ///
    /// * `wed`
    ///
    /// * `thu`
    ///
    /// * `fri`
    ///
    /// * `sat`
    ///
    /// Example: `sun:23:00-mon:01:30`
    preferred_maintenance_window: ?[]const u8,

    /// The outpost ARN in which the cache cluster is created.
    preferred_outpost_arn: ?[]const u8,

    /// The replication group to which this cluster belongs. If this field is empty,
    /// the
    /// cluster is not associated with any replication group.
    replication_group_id: ?[]const u8,

    /// A boolean value indicating whether log delivery is enabled for the
    /// replication
    /// group.
    replication_group_log_delivery_enabled: ?bool,

    /// A list of VPC Security Groups associated with the cluster.
    security_groups: ?[]const SecurityGroupMembership,

    /// The number of days for which ElastiCache retains automatic cluster snapshots
    /// before
    /// deleting them. For example, if you set `SnapshotRetentionLimit` to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    ///
    /// If the value of SnapshotRetentionLimit is set to zero (0), backups are
    /// turned
    /// off.
    snapshot_retention_limit: ?i32,

    /// The daily time range (in UTC) during which ElastiCache begins taking a daily
    /// snapshot
    /// of your cluster.
    ///
    /// Example: `05:00-09:00`
    snapshot_window: ?[]const u8,

    /// A flag that enables in-transit encryption when set to `true`.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    ///
    /// Default: `false`
    transit_encryption_enabled: ?bool,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    transit_encryption_mode: ?TransitEncryptionMode,
};
