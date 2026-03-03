const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const LogDeliveryConfigurationRequest = @import("log_delivery_configuration_request.zig").LogDeliveryConfigurationRequest;
const NetworkType = @import("network_type.zig").NetworkType;
const NodeGroupConfiguration = @import("node_group_configuration.zig").NodeGroupConfiguration;
const Tag = @import("tag.zig").Tag;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const serde = @import("serde.zig");

pub const CreateReplicationGroupInput = struct {
    /// A flag that enables encryption at rest when set to `true`.
    ///
    /// You cannot modify the value of `AtRestEncryptionEnabled` after the
    /// replication group is created. To enable encryption at rest on a replication
    /// group you
    /// must set `AtRestEncryptionEnabled` to `true` when you create the
    /// replication group.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Valkey 7.2 and later, Redis OSS version
    /// `3.2.6`, or Redis OSS `4.x` and
    /// later.
    ///
    /// Default: `true` when using Valkey, `false` when using Redis OSS
    at_rest_encryption_enabled: ?bool = null,

    /// **Reserved parameter.** The password used to access a
    /// password protected server.
    ///
    /// `AuthToken` can be specified only on replication groups where
    /// `TransitEncryptionEnabled` is `true`.
    ///
    /// For HIPAA compliance, you must specify `TransitEncryptionEnabled` as
    /// `true`, an `AuthToken`, and a
    /// `CacheSubnetGroup`.
    ///
    /// Password constraints:
    ///
    /// * Must be only printable ASCII characters.
    ///
    /// * Must be at least 16 characters and no more than 128 characters in
    /// length.
    ///
    /// * The only permitted printable special characters are !, &, #, $, ^, , and
    ///   -. Other printable special characters cannot be used in the AUTH
    /// token.
    ///
    /// For more information, see [AUTH
    /// password](http://redis.io/commands/AUTH) at http://redis.io/commands/AUTH.
    auth_token: ?[]const u8 = null,

    /// Specifies whether a read-only replica is automatically promoted to
    /// read/write primary
    /// if the existing primary fails.
    ///
    /// `AutomaticFailoverEnabled` must be enabled for Valkey or Redis OSS (cluster
    /// mode enabled)
    /// replication groups.
    ///
    /// Default: false
    automatic_failover_enabled: ?bool = null,

    /// If you are running Valkey 7.2 and above or Redis OSS engine version 6.0 and
    /// above, set this parameter to yes
    /// to opt-in to the next auto minor version upgrade campaign. This parameter is
    /// disabled for previous versions.
    auto_minor_version_upgrade: ?bool = null,

    /// The compute and memory capacity of the nodes in the node group (shard).
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
    cache_node_type: ?[]const u8 = null,

    /// The name of the parameter group to associate with this replication group. If
    /// this
    /// argument is omitted, the default cache parameter group for the specified
    /// engine is
    /// used.
    ///
    /// If you are running Valkey or Redis OSS version 3.2.4 or later, only one node
    /// group (shard), and want
    /// to use a default parameter group, we recommend that you specify the
    /// parameter group by
    /// name.
    ///
    /// * To create a Valkey or Redis OSS (cluster mode disabled) replication group,
    ///   use
    /// `CacheParameterGroupName=default.redis3.2`.
    ///
    /// * To create a Valkey or Redis OSS (cluster mode enabled) replication group,
    ///   use
    /// `CacheParameterGroupName=default.redis3.2.cluster.on`.
    cache_parameter_group_name: ?[]const u8 = null,

    /// A list of cache security group names to associate with this replication
    /// group.
    cache_security_group_names: ?[]const []const u8 = null,

    /// The name of the cache subnet group to be used for the replication group.
    ///
    /// If you're going to launch your cluster in an Amazon VPC, you need to create
    /// a
    /// subnet group before you start creating a cluster. For more information, see
    /// [Subnets and Subnet
    /// Groups](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/SubnetGroups.html).
    cache_subnet_group_name: ?[]const u8 = null,

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

    /// Enables data tiering. Data tiering is only supported for replication groups
    /// using the
    /// r6gd node type. This parameter must be set to true when using r6gd nodes.
    /// For more
    /// information, see [Data
    /// tiering](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/data-tiering.html).
    data_tiering_enabled: ?bool = null,

    /// The name of the cache engine to be used for the clusters in this replication
    /// group.
    /// The value must be set to `valkey` or `redis`.
    engine: ?[]const u8 = null,

    /// The version number of the cache engine to be used for the clusters in this
    /// replication
    /// group. To view the supported cache engine versions, use the
    /// `DescribeCacheEngineVersions` operation.
    ///
    /// **Important:** You can upgrade to a newer engine version
    /// (see [Selecting
    /// a Cache Engine and
    /// Version](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/SelectEngine.html#VersionManagement)) in the *ElastiCache User
    /// Guide*, but you cannot downgrade to an earlier engine version. If you want
    /// to use an earlier engine version, you must delete the existing cluster or
    /// replication
    /// group and create it anew with the earlier engine version.
    engine_version: ?[]const u8 = null,

    /// The name of the Global datastore
    global_replication_group_id: ?[]const u8 = null,

    /// The network type you choose when creating a replication group, either
    /// `ipv4` | `ipv6`. IPv6 is supported for workloads using Valkey 7.2 and above,
    /// Redis OSS engine version 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    ip_discovery: ?IpDiscovery = null,

    /// The ID of the KMS key used to encrypt the disk in the cluster.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the destination, format and type of the logs.
    log_delivery_configurations: ?[]const LogDeliveryConfigurationRequest = null,

    /// A flag indicating if you have Multi-AZ enabled to enhance fault tolerance.
    /// For more
    /// information, see [Minimizing Downtime:
    /// Multi-AZ](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/AutoFailover.html).
    multi_az_enabled: ?bool = null,

    /// Must be either `ipv4` | `ipv6` | `dual_stack`. IPv6
    /// is supported for workloads using Valkey 7.2 and above, Redis OSS engine
    /// version 6.2
    /// to 7.1 and Memcached engine version 1.6.6 and above on all instances built
    /// on the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    network_type: ?NetworkType = null,

    /// A list of node group (shard) configuration options. Each node group (shard)
    /// configuration has the following members: `PrimaryAvailabilityZone`,
    /// `ReplicaAvailabilityZones`, `ReplicaCount`, and
    /// `Slots`.
    ///
    /// If you're creating a Valkey or Redis OSS (cluster mode disabled) or a Valkey
    /// or Redis OSS (cluster mode enabled)
    /// replication group, you can use this parameter to individually configure each
    /// node group
    /// (shard), or you can omit this parameter. However, it is required when
    /// seeding a Valkey or Redis OSS (cluster mode enabled) cluster from a S3 rdb
    /// file. You must configure each node group
    /// (shard) using this parameter because you must specify the slots for each
    /// node
    /// group.
    node_group_configuration: ?[]const NodeGroupConfiguration = null,

    /// The Amazon Resource Name (ARN) of the Amazon Simple Notification Service
    /// (SNS) topic
    /// to which notifications are sent.
    ///
    /// The Amazon SNS topic owner must be the same as the cluster owner.
    notification_topic_arn: ?[]const u8 = null,

    /// The number of clusters this replication group initially has.
    ///
    /// This parameter is not used if there is more than one node group (shard). You
    /// should
    /// use `ReplicasPerNodeGroup` instead.
    ///
    /// If `AutomaticFailoverEnabled` is `true`, the value of this
    /// parameter must be at least 2. If `AutomaticFailoverEnabled` is
    /// `false` you can omit this parameter (it will default to 1), or you can
    /// explicitly set it to a value between 2 and 6.
    ///
    /// The maximum permitted value for `NumCacheClusters` is 6 (1 primary plus 5
    /// replicas).
    num_cache_clusters: ?i32 = null,

    /// An optional parameter that specifies the number of node groups (shards) for
    /// this Valkey or Redis OSS (cluster mode enabled) replication group. For
    /// Valkey or Redis OSS (cluster mode disabled) either omit
    /// this parameter or set it to 1.
    ///
    /// Default: 1
    num_node_groups: ?i32 = null,

    /// The port number on which each member of the replication group accepts
    /// connections.
    port: ?i32 = null,

    /// A list of EC2 Availability Zones in which the replication group's clusters
    /// are
    /// created. The order of the Availability Zones in the list is the order in
    /// which clusters
    /// are allocated. The primary cluster is created in the first AZ in the list.
    ///
    /// This parameter is not used if there is more than one node group (shard). You
    /// should
    /// use `NodeGroupConfiguration` instead.
    ///
    /// If you are creating your replication group in an Amazon VPC (recommended),
    /// you can
    /// only locate clusters in Availability Zones associated with the subnets in
    /// the
    /// selected subnet group.
    ///
    /// The number of Availability Zones listed must equal the value of
    /// `NumCacheClusters`.
    ///
    /// Default: system chosen Availability Zones.
    preferred_cache_cluster_a_zs: ?[]const []const u8 = null,

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
    preferred_maintenance_window: ?[]const u8 = null,

    /// The identifier of the cluster that serves as the primary for this
    /// replication group.
    /// This cluster must already exist and have a status of `available`.
    ///
    /// This parameter is not required if `NumCacheClusters`,
    /// `NumNodeGroups`, or `ReplicasPerNodeGroup` is
    /// specified.
    primary_cluster_id: ?[]const u8 = null,

    /// An optional parameter that specifies the number of replica nodes in each
    /// node group
    /// (shard). Valid values are 0 to 5.
    replicas_per_node_group: ?i32 = null,

    /// A user-created description for the replication group.
    replication_group_description: []const u8,

    /// The replication group identifier. This parameter is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * A name must contain from 1 to 40 alphanumeric characters or hyphens.
    ///
    /// * The first character must be a letter.
    ///
    /// * A name cannot end with a hyphen or contain two consecutive hyphens.
    replication_group_id: []const u8,

    /// One or more Amazon VPC security groups associated with this replication
    /// group.
    ///
    /// Use this parameter only when you are creating a replication group in an
    /// Amazon Virtual
    /// Private Cloud (Amazon VPC).
    security_group_ids: ?[]const []const u8 = null,

    /// The name of the snapshot used to create a replication group. Available for
    /// Valkey, Redis OSS only.
    serverless_cache_snapshot_name: ?[]const u8 = null,

    /// A list of Amazon Resource Names (ARN) that uniquely identify the Valkey or
    /// Redis OSS RDB snapshot
    /// files stored in Amazon S3. The snapshot files are used to populate the new
    /// replication
    /// group. The Amazon S3 object name in the ARN cannot contain any commas. The
    /// new
    /// replication group will have the number of node groups (console: shards)
    /// specified by the
    /// parameter *NumNodeGroups* or the number of node groups configured by
    /// *NodeGroupConfiguration* regardless of the number of ARNs
    /// specified here.
    ///
    /// Example of an Amazon S3 ARN: `arn:aws:s3:::my_bucket/snapshot1.rdb`
    snapshot_arns: ?[]const []const u8 = null,

    /// The name of a snapshot from which to restore data into the new replication
    /// group. The
    /// snapshot status changes to `restoring` while the new replication group is
    /// being created.
    snapshot_name: ?[]const u8 = null,

    /// The number of days for which ElastiCache retains automatic snapshots before
    /// deleting
    /// them. For example, if you set `SnapshotRetentionLimit` to 5, a snapshot that
    /// was taken today is retained for 5 days before being deleted.
    ///
    /// Default: 0 (i.e., automatic backups are disabled for this cluster).
    snapshot_retention_limit: ?i32 = null,

    /// The daily time range (in UTC) during which ElastiCache begins taking a daily
    /// snapshot
    /// of your node group (shard).
    ///
    /// Example: `05:00-09:00`
    ///
    /// If you do not specify this parameter, ElastiCache automatically chooses an
    /// appropriate
    /// time range.
    snapshot_window: ?[]const u8 = null,

    /// A list of tags to be added to this resource. Tags are comma-separated
    /// key,value pairs
    /// (e.g. Key=`myKey`, Value=`myKeyValue`. You can include multiple
    /// tags as shown following: Key=`myKey`, Value=`myKeyValue`
    /// Key=`mySecondKey`, Value=`mySecondKeyValue`. Tags on
    /// replication groups will be replicated to all nodes.
    tags: ?[]const Tag = null,

    /// A flag that enables in-transit encryption when set to `true`.
    ///
    /// This parameter is valid only if the `Engine` parameter is
    /// `redis`, the `EngineVersion` parameter is `3.2.6`,
    /// `4.x` or later, and the cluster is being created in an Amazon VPC.
    ///
    /// If you enable in-transit encryption, you must also specify a value for
    /// `CacheSubnetGroup`.
    ///
    /// **Required:** Only available when creating a replication
    /// group in an Amazon VPC using Redis OSS version `3.2.6`, `4.x` or
    /// later.
    ///
    /// Default: `false`
    ///
    /// For HIPAA compliance, you must specify `TransitEncryptionEnabled` as
    /// `true`, an `AuthToken`, and a
    /// `CacheSubnetGroup`.
    transit_encryption_enabled: ?bool = null,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    ///
    /// When setting `TransitEncryptionEnabled` to `true`, you can set
    /// your `TransitEncryptionMode` to `preferred` in the same request,
    /// to allow both encrypted and unencrypted connections at the same time. Once
    /// you migrate
    /// all your Valkey or Redis OSS clients to use encrypted connections you can
    /// modify the value to
    /// `required` to allow encrypted connections only.
    ///
    /// Setting `TransitEncryptionMode` to `required` is a two-step
    /// process that requires you to first set the `TransitEncryptionMode` to
    /// `preferred`, after that you can set `TransitEncryptionMode` to
    /// `required`.
    ///
    /// This process will not trigger the replacement of the replication group.
    transit_encryption_mode: ?TransitEncryptionMode = null,

    /// The user group to associate with the replication group.
    user_group_ids: ?[]const []const u8 = null,
};

pub const CreateReplicationGroupOutput = struct {
    replication_group: ?ReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationGroupInput, options: CallOptions) !CreateReplicationGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticache");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateReplicationGroup&Version=2015-02-02");
    if (input.at_rest_encryption_enabled) |v| {
        try body_buf.appendSlice(allocator, "&AtRestEncryptionEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.auth_token) |v| {
        try body_buf.appendSlice(allocator, "&AuthToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.automatic_failover_enabled) |v| {
        try body_buf.appendSlice(allocator, "&AutomaticFailoverEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cache_node_type) |v| {
        try body_buf.appendSlice(allocator, "&CacheNodeType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cache_parameter_group_name) |v| {
        try body_buf.appendSlice(allocator, "&CacheParameterGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cache_security_group_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CacheSecurityGroupNames.CacheSecurityGroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.cache_subnet_group_name) |v| {
        try body_buf.appendSlice(allocator, "&CacheSubnetGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_mode) |v| {
        try body_buf.appendSlice(allocator, "&ClusterMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.data_tiering_enabled) |v| {
        try body_buf.appendSlice(allocator, "&DataTieringEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.global_replication_group_id) |v| {
        try body_buf.appendSlice(allocator, "&GlobalReplicationGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ip_discovery) |v| {
        try body_buf.appendSlice(allocator, "&IpDiscovery=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.log_delivery_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.destination_details) |sv_1| {
                if (sv_1.cloud_watch_logs_details) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationDetails.CloudWatchLogsDetails.LogGroup=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_2.log_group) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
                if (sv_1.kinesis_firehose_details) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationDetails.KinesisFirehoseDetails.DeliveryStream=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_2.delivery_stream) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.destination_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.Enabled=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.enabled) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.LogFormat=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.log_format) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.LogType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.log_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
        }
    }
    if (input.multi_az_enabled) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.node_group_configuration) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.NodeGroupId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.node_group_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.PrimaryAvailabilityZone=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.primary_availability_zone) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.PrimaryOutpostArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.primary_outpost_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.replica_availability_zones) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.ReplicaAvailabilityZones.AvailabilityZone.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.ReplicaCount=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.replica_count) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.replica_outpost_arns) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.ReplicaOutpostArns.OutpostArn.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NodeGroupConfiguration.NodeGroupConfiguration.{d}.Slots=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.slots) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.notification_topic_arn) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTopicArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.num_cache_clusters) |v| {
        try body_buf.appendSlice(allocator, "&NumCacheClusters=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.num_node_groups) |v| {
        try body_buf.appendSlice(allocator, "&NumNodeGroups=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.port) |v| {
        try body_buf.appendSlice(allocator, "&Port=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_cache_cluster_a_zs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PreferredCacheClusterAZs.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.primary_cluster_id) |v| {
        try body_buf.appendSlice(allocator, "&PrimaryClusterId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.replicas_per_node_group) |v| {
        try body_buf.appendSlice(allocator, "&ReplicasPerNodeGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ReplicationGroupDescription=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.replication_group_description);
    try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.replication_group_id);
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.serverless_cache_snapshot_name) |v| {
        try body_buf.appendSlice(allocator, "&ServerlessCacheSnapshotName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SnapshotArns.SnapshotArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.snapshot_name) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_window) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.transit_encryption_enabled) |v| {
        try body_buf.appendSlice(allocator, "&TransitEncryptionEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.transit_encryption_mode) |v| {
        try body_buf.appendSlice(allocator, "&TransitEncryptionMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.user_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroupIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateReplicationGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicationGroup")) {
                    result.replication_group = try serde.deserializeReplicationGroup(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "APICallRateForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .api_call_rate_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cache_cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cache_cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cache_parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cache_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cache_parameter_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSecurityGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cache_security_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSecurityGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cache_security_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSecurityGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cache_security_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cache_subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSubnetGroupInUse")) {
        return .{ .arena = arena, .kind = .{ .cache_subnet_group_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cache_subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cache_subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CacheSubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cache_subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterQuotaForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_quota_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DefaultUserAssociatedToUserGroupFault")) {
        return .{ .arena = arena, .kind = .{ .default_user_associated_to_user_group_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DefaultUserRequired")) {
        return .{ .arena = arena, .kind = .{ .default_user_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateUserNameFault")) {
        return .{ .arena = arena, .kind = .{ .duplicate_user_name_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalReplicationGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .global_replication_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlobalReplicationGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .global_replication_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCacheClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_cache_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidARNFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCacheClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cache_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCacheParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cache_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCacheSecurityGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cache_security_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGlobalReplicationGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_global_replication_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSKeyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_key_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReplicationGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_replication_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidServerlessCacheSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_serverless_cache_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidServerlessCacheStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_serverless_cache_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoOperationFault")) {
        return .{ .arena = arena, .kind = .{ .no_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .node_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeGroupsPerReplicationGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .node_groups_per_replication_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForClusterExceededFault")) {
        return .{ .arena = arena, .kind = .{ .node_quota_for_cluster_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .node_quota_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .replication_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationGroupAlreadyUnderMigrationFault")) {
        return .{ .arena = arena, .kind = .{ .replication_group_already_under_migration_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .replication_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationGroupNotUnderMigrationFault")) {
        return .{ .arena = arena, .kind = .{ .replication_group_not_under_migration_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedCacheNodeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_cache_node_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedCacheNodeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_cache_node_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedCacheNodeQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_cache_node_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedCacheNodesOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_cache_nodes_offering_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheQuotaForCustomerExceededFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_quota_for_customer_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerlessCacheSnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .serverless_cache_snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUpdateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .service_update_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotFeatureNotSupportedFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_feature_not_supported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotAllowedFault")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_allowed_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .tag_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagQuotaPerResourceExceeded")) {
        return .{ .arena = arena, .kind = .{ .tag_quota_per_resource_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TestFailoverNotAvailableFault")) {
        return .{ .arena = arena, .kind = .{ .test_failover_not_available_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .user_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .user_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .user_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .user_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .user_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .user_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
