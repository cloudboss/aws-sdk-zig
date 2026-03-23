const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AuthTokenUpdateStrategyType = @import("auth_token_update_strategy_type.zig").AuthTokenUpdateStrategyType;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const LogDeliveryConfigurationRequest = @import("log_delivery_configuration_request.zig").LogDeliveryConfigurationRequest;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const serde = @import("serde.zig");

pub const ModifyReplicationGroupInput = struct {
    /// If `true`, this parameter causes the modifications in this request and any
    /// pending modifications to be applied, asynchronously and as soon as possible,
    /// regardless
    /// of the `PreferredMaintenanceWindow` setting for the replication group.
    ///
    /// If `false`, changes to the nodes in the replication group are applied on
    /// the next maintenance reboot, or the next failure reboot, whichever occurs
    /// first.
    ///
    /// Valid values: `true` | `false`
    ///
    /// Default: `false`
    apply_immediately: ?bool = null,

    /// Reserved parameter. The password used to access a password protected server.
    /// This
    /// parameter must be specified with the `auth-token-update-strategy `
    /// parameter.
    /// Password constraints:
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

    /// Determines whether a read replica is automatically promoted to read/write
    /// primary if
    /// the existing primary encounters a failure.
    ///
    /// Valid values: `true` | `false`
    automatic_failover_enabled: ?bool = null,

    /// If you are running Valkey or Redis OSS engine version 6.0 or later, set this
    /// parameter to yes if
    /// you want to opt-in to the next auto minor version upgrade campaign. This
    /// parameter is
    /// disabled for previous versions.
    auto_minor_version_upgrade: ?bool = null,

    /// A valid cache node type that you want to scale this replication group to.
    cache_node_type: ?[]const u8 = null,

    /// The name of the cache parameter group to apply to all of the clusters in
    /// this
    /// replication group. This change is asynchronously applied as soon as possible
    /// for
    /// parameters when the `ApplyImmediately` parameter is specified as
    /// `true` for this request.
    cache_parameter_group_name: ?[]const u8 = null,

    /// A list of cache security group names to authorize for the clusters in this
    /// replication
    /// group. This change is asynchronously applied as soon as possible.
    ///
    /// This parameter can be used only with replication group containing clusters
    /// running
    /// outside of an Amazon Virtual Private Cloud (Amazon VPC).
    ///
    /// Constraints: Must contain no more than 255 alphanumeric characters. Must not
    /// be
    /// `Default`.
    cache_security_group_names: ?[]const []const u8 = null,

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

    /// Modifies the engine listed in a replication group message. The options are
    /// redis, memcached or valkey.
    engine: ?[]const u8 = null,

    /// The upgraded version of the cache engine to be run on the clusters in the
    /// replication
    /// group.
    ///
    /// **Important:** You can upgrade to a newer engine version
    /// (see [Selecting
    /// a Cache Engine and
    /// Version](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/SelectEngine.html#VersionManagement)), but you cannot downgrade to an earlier engine
    /// version. If you want to use an earlier engine version, you must delete the
    /// existing
    /// replication group and create it anew with the earlier engine version.
    engine_version: ?[]const u8 = null,

    /// The network type you choose when modifying a cluster, either `ipv4` |
    /// `ipv6`. IPv6 is supported for workloads using Valkey 7.2 and above, Redis
    /// OSS engine version 6.2
    /// to 7.1 and Memcached engine version 1.6.6 and above on all instances built
    /// on the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    ip_discovery: ?IpDiscovery = null,

    /// Specifies the destination, format and type of the logs.
    log_delivery_configurations: ?[]const LogDeliveryConfigurationRequest = null,

    /// A flag to indicate MultiAZ is enabled.
    multi_az_enabled: ?bool = null,

    /// Deprecated. This parameter is not used.
    node_group_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to which
    /// notifications are
    /// sent.
    ///
    /// The Amazon SNS topic owner must be same as the replication group owner.
    notification_topic_arn: ?[]const u8 = null,

    /// The status of the Amazon SNS notification topic for the replication group.
    /// Notifications are sent only if the status is `active`.
    ///
    /// Valid values: `active` | `inactive`
    notification_topic_status: ?[]const u8 = null,

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

    /// For replication groups with a single primary, if this parameter is
    /// specified,
    /// ElastiCache promotes the specified cluster in the specified replication
    /// group to the
    /// primary role. The nodes of all other clusters in the replication group are
    /// read
    /// replicas.
    primary_cluster_id: ?[]const u8 = null,

    /// Removes the user group associated with this replication group.
    remove_user_groups: ?bool = null,

    /// A description for the replication group. Maximum length is 255 characters.
    replication_group_description: ?[]const u8 = null,

    /// The identifier of the replication group to modify.
    replication_group_id: []const u8,

    /// Specifies the VPC Security Groups associated with the clusters in the
    /// replication
    /// group.
    ///
    /// This parameter can be used only with replication group containing clusters
    /// running in
    /// an Amazon Virtual Private Cloud (Amazon VPC).
    security_group_ids: ?[]const []const u8 = null,

    /// The number of days for which ElastiCache retains automatic node group
    /// (shard)
    /// snapshots before deleting them. For example, if you set
    /// `SnapshotRetentionLimit` to 5, a snapshot that was taken today is
    /// retained for 5 days before being deleted.
    ///
    /// **Important** If the value of SnapshotRetentionLimit is
    /// set to zero (0), backups are turned off.
    snapshot_retention_limit: ?i32 = null,

    /// The cluster ID that is used as the daily snapshot source for the replication
    /// group.
    /// This parameter cannot be set for Valkey or Redis OSS (cluster mode enabled)
    /// replication groups.
    snapshotting_cluster_id: ?[]const u8 = null,

    /// The daily time range (in UTC) during which ElastiCache begins taking a daily
    /// snapshot
    /// of the node group (shard) specified by `SnapshottingClusterId`.
    ///
    /// Example: `05:00-09:00`
    ///
    /// If you do not specify this parameter, ElastiCache automatically chooses an
    /// appropriate
    /// time range.
    snapshot_window: ?[]const u8 = null,

    /// A flag that enables in-transit encryption when set to true. If you are
    /// enabling
    /// in-transit encryption for an existing cluster, you must also set
    /// `TransitEncryptionMode` to `preferred`.
    transit_encryption_enabled: ?bool = null,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    ///
    /// You must set `TransitEncryptionEnabled` to `true`, for your
    /// existing cluster, and set `TransitEncryptionMode` to `preferred`
    /// in the same request to allow both encrypted and unencrypted connections at
    /// the same
    /// time. Once you migrate all your Valkey or Redis OSS clients to use encrypted
    /// connections you can set
    /// the value to `required` to allow encrypted connections only.
    ///
    /// Setting `TransitEncryptionMode` to `required` is a two-step
    /// process that requires you to first set the `TransitEncryptionMode` to
    /// `preferred`, after that you can set `TransitEncryptionMode` to
    /// `required`.
    transit_encryption_mode: ?TransitEncryptionMode = null,

    /// The ID of the user group you are associating with the replication group.
    user_group_ids_to_add: ?[]const []const u8 = null,

    /// The ID of the user group to disassociate from the replication group, meaning
    /// the users
    /// in the group no longer can access the replication group.
    user_group_ids_to_remove: ?[]const []const u8 = null,
};

pub const ModifyReplicationGroupOutput = struct {
    replication_group: ?ReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationGroupInput, options: CallOptions) !ModifyReplicationGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyReplicationGroup&Version=2015-02-02");
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
    if (input.cluster_mode) |v| {
        try body_buf.appendSlice(allocator, "&ClusterMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.multi_az_enabled) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.node_group_id) |v| {
        try body_buf.appendSlice(allocator, "&NodeGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.notification_topic_arn) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTopicArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.notification_topic_status) |v| {
        try body_buf.appendSlice(allocator, "&NotificationTopicStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.preferred_maintenance_window) |v| {
        try body_buf.appendSlice(allocator, "&PreferredMaintenanceWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.primary_cluster_id) |v| {
        try body_buf.appendSlice(allocator, "&PrimaryClusterId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.remove_user_groups) |v| {
        try body_buf.appendSlice(allocator, "&RemoveUserGroups=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.replication_group_description) |v| {
        try body_buf.appendSlice(allocator, "&ReplicationGroupDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshotting_cluster_id) |v| {
        try body_buf.appendSlice(allocator, "&SnapshottingClusterId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_window) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotWindow=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.transit_encryption_enabled) |v| {
        try body_buf.appendSlice(allocator, "&TransitEncryptionEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.transit_encryption_mode) |v| {
        try body_buf.appendSlice(allocator, "&TransitEncryptionMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.user_group_ids_to_add) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroupIdsToAdd.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.user_group_ids_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroupIdsToRemove.member.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyReplicationGroupOutput = .{};
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
