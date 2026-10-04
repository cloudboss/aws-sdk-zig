const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheUsageLimits = @import("cache_usage_limits.zig").CacheUsageLimits;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const ServerlessCache = @import("serverless_cache.zig").ServerlessCache;
const serde = @import("serde.zig");

pub const CreateServerlessCacheInput = struct {
    /// Sets the cache usage limits for storage and ElastiCache Processing Units for
    /// the cache.
    cache_usage_limits: ?CacheUsageLimits = null,

    /// The daily time that snapshots will be created from the new serverless cache.
    /// By default this number is populated with
    /// 0, i.e. no snapshots will be created on an automatic daily basis. Available
    /// for Valkey, Redis OSS and Serverless Memcached only.
    daily_snapshot_time: ?[]const u8 = null,

    /// User-provided description for the serverless cache.
    /// The default is NULL, i.e. if no description is provided then an empty string
    /// will be returned.
    /// The maximum length is 255 characters.
    description: ?[]const u8 = null,

    /// The name of the cache engine to be used for creating the serverless cache.
    engine: []const u8,

    /// ARN of the customer managed key for encrypting the data at rest. If no KMS
    /// key is provided, a default service key is used.
    kms_key_id: ?[]const u8 = null,

    /// The version of the cache engine that will be used to create the serverless
    /// cache.
    major_engine_version: ?[]const u8 = null,

    /// The IP protocol version used by the serverless cache.
    /// Must be either `ipv4` | `ipv6` | `dual_stack`.
    /// `ipv6` is only supported with ipv6-only subnets.
    /// If not specified, defaults to `ipv4`, unless all provided subnets are
    /// IPv6-only, in which case it defaults to `ipv6`.
    network_type: ?NetworkType = null,

    /// A list of the one or more VPC security groups to be associated with the
    /// serverless cache.
    /// The security group will authorize traffic access for the VPC end-point
    /// (private-link).
    /// If no other information is given this will be the VPC’s Default Security
    /// Group that is associated with the cluster VPC
    /// end-point.
    security_group_ids: ?[]const []const u8 = null,

    /// User-provided identifier for the serverless cache. This parameter is stored
    /// as a lowercase string.
    serverless_cache_name: []const u8,

    /// The ARN(s) of the snapshot that the new serverless cache will be created
    /// from. Available for Valkey, Redis OSS and Serverless Memcached only.
    snapshot_arns_to_restore: ?[]const []const u8 = null,

    /// The number of days for which ElastiCache retains automatic snapshots before
    /// deleting them.
    /// Available for Valkey, Redis OSS and Serverless Memcached only. The maximum
    /// value allowed is 35 days.
    snapshot_retention_limit: ?i32 = null,

    /// A list of the identifiers of the subnets where the VPC endpoint for the
    /// serverless cache will be deployed.
    /// All the subnetIds must belong to the same VPC.
    subnet_ids: ?[]const []const u8 = null,

    /// The list of tags (key, value) pairs to be added to the serverless cache
    /// resource. Default is NULL.
    tags: ?[]const Tag = null,

    /// The identifier of the UserGroup to be associated with the serverless cache.
    /// Available for Valkey and Redis OSS only. Default is NULL.
    user_group_id: ?[]const u8 = null,
};

pub const CreateServerlessCacheOutput = struct {
    /// The response for the attempt to create the serverless cache.
    serverless_cache: ?ServerlessCache = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServerlessCacheInput, options: CallOptions) !CreateServerlessCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServerlessCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateServerlessCache&Version=2015-02-02");
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
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.major_engine_version) |v| {
        try body_buf.appendSlice(allocator, "&MajorEngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.network_type) |v| {
        try body_buf.appendSlice(allocator, "&NetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    if (input.snapshot_arns_to_restore) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SnapshotArnsToRestore.SnapshotArn.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.snapshot_retention_limit) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotRetentionLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetIds.SubnetId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServerlessCacheOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateServerlessCacheResult")) break;
            },
            else => {},
        }
    }

    var result: CreateServerlessCacheOutput = .{};
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
