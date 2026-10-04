const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    /// valkey, memcached or redis.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyServerlessCacheInput, options: CallOptions) !ModifyServerlessCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyServerlessCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyServerlessCache&Version=2015-02-02");
    if (input.cache_usage_limits) |v| {
        if (v.data_storage) |sv| {
            if (sv.maximum) |sv2| {
                try body_buf.appendSlice(allocator, "&CacheUsageLimits.DataStorage.Maximum=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.minimum) |sv2| {
                try body_buf.appendSlice(allocator, "&CacheUsageLimits.DataStorage.Minimum=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            try body_buf.appendSlice(allocator, "&CacheUsageLimits.DataStorage.Unit=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.unit.wireName());
        }
        if (v.ecpu_per_second) |sv| {
            if (sv.maximum) |sv2| {
                try body_buf.appendSlice(allocator, "&CacheUsageLimits.ECPUPerSecond.Maximum=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.minimum) |sv2| {
                try body_buf.appendSlice(allocator, "&CacheUsageLimits.ECPUPerSecond.Minimum=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
        }
    }
    if (input.daily_snapshot_time) |v| {
        try body_buf.appendSlice(allocator, "&DailySnapshotTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.major_engine_version) |v| {
        try body_buf.appendSlice(allocator, "&MajorEngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.remove_user_group) |v| {
        try body_buf.appendSlice(allocator, "&RemoveUserGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
    try body_buf.appendSlice(allocator, "&ServerlessCacheName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serverless_cache_name);
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.user_group_id) |v| {
        try body_buf.appendSlice(allocator, "&UserGroupId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyServerlessCacheOutput {
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
                    result.serverless_cache = try serde.deserializeServerlessCache(allocator, &reader);
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
