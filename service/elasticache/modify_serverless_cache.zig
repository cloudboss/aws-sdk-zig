const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CacheUsageLimits = @import("cache_usage_limits.zig").CacheUsageLimits;
const ServerlessCache = @import("serverless_cache.zig").ServerlessCache;
const serde = @import("serde.zig");

pub const ModifyServerlessCacheInput = struct {
    /// Modify the cache usage limit for the serverless cache.
    cache_usage_limits: ?CacheUsageLimits = null,

    /// The daily time during which Elasticache begins taking a daily snapshot of
    /// the serverless cache. Available for Valkey, Redis OSS and Serverless
    /// Memcached only.
    /// The default is NULL, i.e. the existing snapshot time configured for the
    /// cluster is not removed.
    daily_snapshot_time: ?[]const u8 = null,

    /// User provided description for the serverless cache.
    /// Default = NULL, i.e. the existing description is not removed/modified.
    /// The description has a maximum length of 255 characters.
    description: ?[]const u8 = null,

    /// Modifies the engine listed in a serverless cache request. The options are
    /// redis, memcached or valkey.
    engine: ?[]const u8 = null,

    /// Modifies the engine vesion listed in a serverless cache request.
    major_engine_version: ?[]const u8 = null,

    /// The identifier of the UserGroup to be removed from association with the
    /// Valkey and Redis OSS serverless cache. Available for Valkey and Redis OSS
    /// only. Default is NULL.
    remove_user_group: ?bool = null,

    /// The new list of VPC security groups to be associated with the serverless
    /// cache.
    /// Populating this list means the current VPC security groups will be removed.
    /// This security group is used to authorize traffic access for the VPC
    /// end-point (private-link).
    /// Default = NULL - the existing list of VPC security groups is not removed.
    security_group_ids: ?[]const []const u8 = null,

    /// User-provided identifier for the serverless cache to be modified.
    serverless_cache_name: []const u8,

    /// The number of days for which Elasticache retains automatic snapshots before
    /// deleting them.
    /// Available for Valkey, Redis OSS and Serverless Memcached only.
    /// Default = NULL, i.e. the existing snapshot-retention-limit will not be
    /// removed or modified.
    /// The maximum value allowed is 35 days.
    snapshot_retention_limit: ?i32 = null,

    /// The identifier of the UserGroup to be associated with the serverless cache.
    /// Available for Valkey and Redis OSS only.
    /// Default is NULL - the existing UserGroup is not removed.
    user_group_id: ?[]const u8 = null,
};

pub const ModifyServerlessCacheOutput = struct {
    /// The response for the attempt to modify the serverless cache.
    serverless_cache: ?ServerlessCache = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyServerlessCacheInput, options: Options) !ModifyServerlessCacheOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyServerlessCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyServerlessCache&Version=2015-02-02");
    if (input.cache_usage_limits) |v| {
        if (v.data_storage) |sv| {
            if (sv.maximum) |sv2| {
                try body_buf.appendSlice(alloc, "&CacheUsageLimits.DataStorage.Maximum=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.minimum) |sv2| {
                try body_buf.appendSlice(alloc, "&CacheUsageLimits.DataStorage.Minimum=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            try body_buf.appendSlice(alloc, "&CacheUsageLimits.DataStorage.Unit=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv.unit));
        }
        if (v.ecpu_per_second) |sv| {
            if (sv.maximum) |sv2| {
                try body_buf.appendSlice(alloc, "&CacheUsageLimits.ECPUPerSecond.Maximum=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
            if (sv.minimum) |sv2| {
                try body_buf.appendSlice(alloc, "&CacheUsageLimits.ECPUPerSecond.Minimum=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
            }
        }
    }
    if (input.daily_snapshot_time) |v| {
        try body_buf.appendSlice(alloc, "&DailySnapshotTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(alloc, "&Engine=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.major_engine_version) |v| {
        try body_buf.appendSlice(alloc, "&MajorEngineVersion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.remove_user_group) |v| {
        try body_buf.appendSlice(alloc, "&RemoveUserGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&ServerlessCacheName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.serverless_cache_name);
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(alloc, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.user_group_id) |v| {
        try body_buf.appendSlice(alloc, "&UserGroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyServerlessCacheOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyServerlessCacheResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyServerlessCacheOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServerlessCache")) {
                    result.serverless_cache = try serde.deserializeServerlessCache(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
