const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthTokenUpdateStrategyType = @import("auth_token_update_strategy_type.zig").AuthTokenUpdateStrategyType;
const AZMode = @import("az_mode.zig").AZMode;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const LogDeliveryConfigurationRequest = @import("log_delivery_configuration_request.zig").LogDeliveryConfigurationRequest;
const ScaleConfig = @import("scale_config.zig").ScaleConfig;
const CacheCluster = @import("cache_cluster.zig").CacheCluster;
const serde = @import("serde.zig");

pub const ModifyCacheClusterInput = struct {
    /// If `true`, this parameter causes the modifications in this request and any
    /// pending modifications to be applied, asynchronously and as soon as possible,
    /// regardless
    /// of the `PreferredMaintenanceWindow` setting for the cluster.
    ///
    /// If `false`, changes to the cluster are applied on the next maintenance
    /// reboot, or the next failure reboot, whichever occurs first.
    ///
    /// If you perform a `ModifyCacheCluster` before a pending modification is
    /// applied, the pending modification is replaced by the newer modification.
    /// However,
    /// a pending node-count increase on Memcached clusters cannot be superseded by
    /// a request
    /// to add fewer nodes. To change a pending node addition, first cancel it by
    /// setting
    /// `NumCacheNodes` equal to the current number of nodes in the cluster, then
    /// submit the new request. See the `NumCacheNodes` parameter for details on
    /// node scaling behavior.
    ///
    /// Valid values: `true` | `false`
    ///
    /// Default: `false`
    apply_immediately: ?bool = null,

    /// Reserved parameter. The password used to access a password protected server.
    /// This
    /// parameter must be specified with the `auth-token-update` parameter. Password
    /// constraints:
    ///
    /// * Must be only printable ASCII characters
    ///
    /// * Must be at least 16 characters and no more than 128 characters in
    /// length
    ///
    /// * Cannot contain any of the following characters: '/', '"', or '@', '%'
    ///
    /// For more information, see AUTH password at
    /// [AUTH](http://redis.io/commands/AUTH).
    auth_token: ?[]const u8 = null,

    /// Specifies the strategy to use to update the AUTH token. This parameter must
    /// be
    /// specified with the `auth-token` parameter. Possible values:
    ///
    /// * ROTATE - default, if no update strategy is provided
    ///
    /// * SET - allowed only after ROTATE
    ///
    /// * DELETE - allowed only when transitioning to RBAC
    ///
    /// For more information, see [Authenticating Users with
    /// AUTH](http://docs.aws.amazon.com/AmazonElastiCache/latest/dg/auth.html)
    auth_token_update_strategy: ?AuthTokenUpdateStrategyType = null,

    /// If you are running Valkey 7.2 or Redis OSS engine version 6.0 or later, set
    /// this parameter to yes
    /// to opt-in to the next auto minor version upgrade campaign. This parameter is
    /// disabled for previous versions.
    auto_minor_version_upgrade: ?bool = null,

    /// Specifies whether the new nodes in this Memcached cluster are all created in
    /// a single
    /// Availability Zone or created across multiple Availability Zones.
    ///
    /// Valid values: `single-az` | `cross-az`.
    ///
    /// This option is only supported for Memcached clusters.
    ///
    /// You cannot specify `single-az` if the Memcached cluster already has
    /// cache nodes in different Availability Zones. If `cross-az` is specified,
    /// existing Memcached nodes remain in their current Availability Zone.
    ///
    /// Only newly created nodes are located in different Availability Zones.
    az_mode: ?AZMode = null,

    /// The cluster identifier. This value is stored as a lowercase string.
    cache_cluster_id: []const u8,

    /// A list of cache node IDs to be removed. A node ID is a numeric identifier
    /// (0001, 0002,
    /// etc.). This parameter is only valid when `NumCacheNodes` is less than the
    /// existing number of cache nodes. The number of cache node IDs supplied in
    /// this parameter
    /// must match the difference between the existing number of cache nodes in the
    /// cluster or
    /// pending cache nodes, whichever is greater, and the value of `NumCacheNodes`
    /// in the request.
    ///
    /// For example: If you have 3 active cache nodes, 7 pending cache nodes, and
    /// the number
    /// of cache nodes in this `ModifyCacheCluster` call is 5, you must list 2 (7 -
    /// 5) cache node IDs to remove.
    cache_node_ids_to_remove: ?[]const []const u8 = null,

    /// A valid cache node type that you want to scale this cluster up to.
    cache_node_type: ?[]const u8 = null,

    /// The name of the cache parameter group to apply to this cluster. This change
    /// is
    /// asynchronously applied as soon as possible for parameters when the
    /// `ApplyImmediately` parameter is specified as `true` for this
    /// request.
    cache_parameter_group_name: ?[]const u8 = null,

    /// A list of cache security group names to authorize on this cluster. This
    /// change is
    /// asynchronously applied as soon as possible.
    ///
    /// You can use this parameter only with clusters that are created outside of an
    /// Amazon
    /// Virtual Private Cloud (Amazon VPC).
    ///
    /// Constraints: Must contain no more than 255 alphanumeric characters. Must not
    /// be
    /// "Default".
    cache_security_group_names: ?[]const []const u8 = null,

    /// The engine type used by the cache cluster. The options are valkey, memcached
    /// or redis.
    engine: ?[]const u8 = null,

    /// The upgraded version of the cache engine to be run on the cache nodes.
    ///
    /// **Important:** You can upgrade to a newer engine version
    /// (see [Selecting
    /// a Cache Engine and
    /// Version](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/SelectEngine.html#VersionManagement)), but you cannot downgrade to an earlier engine
    /// version. If you want to use an earlier engine version, you must delete the
    /// existing
    /// cluster and create it anew with the earlier engine version.
    engine_version: ?[]const u8 = null,

    /// The network type you choose when modifying a cluster, either `ipv4` |
    /// `ipv6`. IPv6 is supported for workloads using Valkey 7.2 and above, Redis
    /// OSS engine version 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    ip_discovery: ?IpDiscovery = null,

    /// Specifies the destination, format and type of the logs.
    log_delivery_configurations: ?[]const LogDeliveryConfigurationRequest = null,

    /// This option is only supported on Memcached clusters.
    ///
    /// The list of Availability Zones where the new Memcached cache nodes are
    /// created.
    ///
    /// This parameter is only valid when `NumCacheNodes` in the request is greater
    /// than the sum of the number of active cache nodes and the number of cache
    /// nodes pending
    /// creation (which may be zero). The number of Availability Zones supplied in
    /// this list
    /// must match the cache nodes being added in this request.
    ///
    /// Scenarios:
    ///
    /// * **Scenario 1:** You have 3 active nodes and wish
    /// to add 2 nodes. Specify `NumCacheNodes=5` (3 + 2) and optionally
    /// specify two Availability Zones for the two new nodes.
    ///
    /// * **Scenario 2:** You have 3 active nodes and 2
    /// nodes pending creation (from the scenario 1 call) and want to add 1 more
    /// node.
    /// Specify `NumCacheNodes=6` ((3 + 2) + 1) and optionally specify an
    /// Availability Zone for the new node.
    ///
    /// * **Scenario 3:** You want to cancel all pending
    /// operations. Specify `NumCacheNodes=3` to cancel all pending
    /// operations.
    ///
    /// The Availability Zone placement of nodes pending creation cannot be
    /// modified. If you
    /// wish to cancel any nodes pending creation, add 0 nodes by setting
    /// `NumCacheNodes` to the number of current nodes.
    ///
    /// If `cross-az` is specified, existing Memcached nodes remain in their
    /// current Availability Zone. Only newly created nodes can be located in
    /// different
    /// Availability Zones. For guidance on how to move existing Memcached nodes to
    /// different
    /// Availability Zones, see the **Availability Zone
    /// Considerations** section of [Cache Node
    /// Considerations for
    /// Memcached](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/CacheNodes.SupportedTypes.html).
    ///
    /// **Impact of new add/remove requests upon pending requests**
    ///
    /// * Scenario-1
    ///
    /// * Pending Action: Delete
    ///
    /// * New Request: Delete
    ///
    /// * Result: The new delete, pending or immediate, replaces the pending
    /// delete.
    ///
    /// * Scenario-2
    ///
    /// * Pending Action: Delete
    ///
    /// * New Request: Create
    ///
    /// * Result: The new create, pending or immediate, replaces the pending
    /// delete.
    ///
    /// * Scenario-3
    ///
    /// * Pending Action: Create
    ///
    /// * New Request: Delete
    ///
    /// * Result: The new delete, pending or immediate, replaces the pending
    /// create.
    ///
    /// * Scenario-4
    ///
    /// * Pending Action: Create
    ///
    /// * New Request: Create
    ///
    /// * Result: The new create is added to the pending create.
    ///
    /// **Important:** If the new create
    /// request is **Apply Immediately - Yes**,
    /// all creates are performed immediately. If the new create request is
    /// **Apply Immediately - No**, all
    /// creates are pending.
    new_availability_zones: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to which
    /// notifications are
    /// sent.
    ///
    /// The Amazon SNS topic owner must be same as the cluster owner.
    notification_topic_arn: ?[]const u8 = null,

    /// The status of the Amazon SNS notification topic. Notifications are sent only
    /// if the
    /// status is `active`.
    ///
    /// Valid values: `active` | `inactive`
    notification_topic_status: ?[]const u8 = null,

    /// The number of cache nodes that the cluster should have. If the value for
    /// `NumCacheNodes` is greater than the sum of the number of current cache
    /// nodes and the number of cache nodes pending creation (which may be zero),
    /// more nodes are
    /// added. If the value is less than the number of existing cache nodes, nodes
    /// are removed.
    /// If the value is equal to the number of current cache nodes, any pending add
    /// or remove
    /// requests are canceled.
    ///
    /// If you are removing cache nodes, you must use the `CacheNodeIdsToRemove`
    /// parameter to provide the IDs of the specific cache nodes to remove.
    ///
    /// For clusters running Valkey or Redis OSS, this value must be 1. For clusters
    /// running Memcached, this
    /// value must be between 1 and 40.
    ///
    /// Adding or removing Memcached cache nodes can be applied immediately or as a
    /// pending operation (see `ApplyImmediately`).
    ///
    /// A pending operation to modify the number of cache nodes in a cluster during
    /// its
    /// maintenance window, whether by adding or removing nodes in accordance with
    /// the scale
    /// out architecture, is not queued. The customer's latest request to add or
    /// remove
    /// nodes to the cluster overrides any previous pending operations to modify the
    /// number
    /// of cache nodes in the cluster. For example, a request to remove 2 nodes
    /// would
    /// override a previous pending operation to remove 3 nodes. Similarly, a
    /// request to add
    /// 2 nodes would override a previous pending operation to remove 3 nodes and
    /// vice
    /// versa. As Memcached cache nodes may now be provisioned in different
    /// Availability
    /// Zones with flexible cache node placement, a request to add nodes does not
    /// automatically override a previous pending operation to add nodes. The
    /// customer can
    /// modify the previous pending operation to add more nodes or explicitly cancel
    /// the
    /// pending request and retry the new request. To cancel pending operations to
    /// modify
    /// the number of cache nodes in a cluster, use the `ModifyCacheCluster`
    /// request and set `NumCacheNodes` equal to the number of cache nodes
    /// currently in the cluster.
    num_cache_nodes: ?i32 = null,

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

    /// Configures horizontal or vertical scaling for Memcached clusters, specifying
    /// the scaling percentage and interval.
    scale_config: ?ScaleConfig = null,

    /// Specifies the VPC Security Groups associated with the cluster.
    ///
    /// This parameter can be used only with clusters that are created in an Amazon
    /// Virtual
    /// Private Cloud (Amazon VPC).
    security_group_ids: ?[]const []const u8 = null,

    /// The number of days for which ElastiCache retains automatic cluster snapshots
    /// before
    /// deleting them. For example, if you set `SnapshotRetentionLimit` to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    ///
    /// If the value of `SnapshotRetentionLimit` is set to zero (0), backups
    /// are turned off.
    snapshot_retention_limit: ?i32 = null,

    /// The daily time range (in UTC) during which ElastiCache begins taking a daily
    /// snapshot
    /// of your cluster.
    snapshot_window: ?[]const u8 = null,
};

pub const ModifyCacheClusterOutput = struct {
    cache_cluster: ?CacheCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCacheClusterInput, options: CallOptions) !ModifyCacheClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCacheClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCacheCluster&Version=2015-02-02");
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.auth_token) |v| {
        try body_buf.appendSlice(allocator, "&AuthToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.auth_token_update_strategy) |v| {
        try body_buf.appendSlice(allocator, "&AuthTokenUpdateStrategy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.auto_minor_version_upgrade) |v| {
        try body_buf.appendSlice(allocator, "&AutoMinorVersionUpgrade=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.az_mode) |v| {
        try body_buf.appendSlice(allocator, "&AZMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&CacheClusterId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_cluster_id);
    if (input.cache_node_ids_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CacheNodeIdsToRemove.CacheNodeId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
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
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ip_discovery) |v| {
        try body_buf.appendSlice(allocator, "&IpDiscovery=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.log_delivery_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.destination_details) |sv_1| {
                if (sv_1.cloud_watch_logs_details) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.log_group) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationDetails.CloudWatchLogsDetails.LogGroup=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
                if (sv_1.kinesis_firehose_details) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.delivery_stream) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationDetails.KinesisFirehoseDetails.DeliveryStream=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.destination_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.DestinationType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.enabled) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.Enabled=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.log_format) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.LogFormat=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.log_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LogDeliveryConfigurations.LogDeliveryConfigurationRequest.{d}.LogType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
        }
    }
    if (input.new_availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NewAvailabilityZones.PreferredAvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.notification_topic_arn) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTopicArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.notification_topic_status) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTopicStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.num_cache_nodes) |v| {
        try body_buf.appendSlice(allocator, "&NumCacheNodes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.scale_config) |v| {
        if (v.scale_interval_minutes) |sv| {
            try body_buf.appendSlice(allocator, "&ScaleConfig.ScaleIntervalMinutes=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.scale_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&ScaleConfig.ScalePercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_window) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCacheClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyCacheClusterResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyCacheClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheCluster")) {
                    result.cache_cluster = try serde.deserializeCacheCluster(allocator, &reader);
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
